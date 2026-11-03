import {useEffect,useRef,useState} from 'react';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import {Crosshair,ExternalLink,MapPin} from 'lucide-react';

const MUMBAI=[19.076,72.8777];
const TILE_SERVERS=['mt0','mt1','mt2','mt3'];

const GOOGLE_LAYERS={
  roadmap:{
    url:'https://{s}.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}',
    attribution:'&copy; <a href="https://www.google.com/maps" target="_blank" rel="noreferrer">Google Maps</a>'
  },
  satellite:{
    url:'https://{s}.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}',
    attribution:'Imagery &copy; <a href="https://www.google.com/maps" target="_blank" rel="noreferrer">Google</a>'
  }
};

/* Default positions are used until the backend network arrives. */
const KNOWN_POSITIONS={
  bhandup:[19.1445,72.937],powai:[19.1176,72.906],andheri:[19.1197,72.8464],dadar:[19.0178,72.8478],
  plant_01:[19.22,72.97],res_01:[19.1,72.9],zone_01:[19.1364,72.8296],zone_02:[19.0178,72.8478]
};

const DROPLET='<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 22a7 7 0 0 0 7-7c0-2-1-3.9-3-5.5s-3.5-4-4-6.5c-.5 2.5-2 4.9-4 6.5C6 11.1 5 13 5 15a7 7 0 0 0 7 7z"/></svg>';

function escapeHtml(value){
  return String(value??'').replace(/[&<>"']/g,ch=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[ch]));
}

function position(station,index){
  const lat=Number(station.lat),lon=Number(station.lon);
  if(Number.isFinite(lat)&&Number.isFinite(lon))return [lat,lon];
  if(KNOWN_POSITIONS[station.id])return KNOWN_POSITIONS[station.id];
  const ring=Math.floor(index/6),angle=(index%6)/6*Math.PI*2;
  return [MUMBAI[0]+Math.cos(angle)*(0.018+ring*0.012),MUMBAI[1]+Math.sin(angle)*(0.022+ring*0.015)];
}

function stationPoints(stations){
  return (stations||[]).map(position);
}

function makeTiles(mode){
  const config=GOOGLE_LAYERS[mode]||GOOGLE_LAYERS.roadmap;
  return L.tileLayer(config.url,{
    subdomains:TILE_SERVERS,
    minZoom:3,
    maxZoom:20,
    maxNativeZoom:20,
    attribution:config.attribution,
    updateWhenIdle:false,
    updateWhenZooming:false,
    keepBuffer:4
  });
}

export default function NetworkMap({stations=[],nodes=[],onSelect,full=false,reports=[],pickCenter=null,pin=null,onPinChange=null}){
  const canvasRef=useRef(null);
  const mapRef=useRef(null);
  const tilesRef=useRef(null);
  const networkRef=useRef(null);
  const stationRef=useRef(null);
  const fitRef=useRef(null);
  const reportLayerRef=useRef(null),pinLayerRef=useRef(null),pinCallback=useRef(onPinChange);pinCallback.current=onPinChange;
  const [showReports,setShowReports]=useState(true);
  const lastFitRef=useRef('');
  const dataRef=useRef({stations,nodes,onSelect});
  const [mode,setMode]=useState('roadmap');

  dataRef.current={stations,nodes,onSelect};

  useEffect(()=>{
    if(!canvasRef.current||mapRef.current)return;
    const reduceMotion=window.matchMedia?.('(prefers-reduced-motion: reduce)').matches;
    const map=L.map(canvasRef.current,{
      center:MUMBAI,
      zoom:12,
      minZoom:3,
      maxZoom:20,
      zoomControl:false,
      attributionControl:false,
      zoomAnimation:false,
      fadeAnimation:!reduceMotion,
      markerZoomAnimation:false,
      zoomSnap:.5,
      zoomDelta:.5,
      wheelPxPerZoomLevel:100,
      wheelDebounceTime:30,
      inertia:!reduceMotion,
      inertiaDeceleration:3400,
      easeLinearity:.2,
      preferCanvas:true,
      worldCopyJump:true
    });
    mapRef.current=map;
    L.control.zoom({position:'bottomright',zoomInTitle:'Zoom in',zoomOutTitle:'Zoom out'}).addTo(map);
    L.control.attribution({position:'bottomleft',prefix:false}).addTo(map);

    map.createPane('networkPane');
    map.getPane('networkPane').style.zIndex=385;
    map.createPane('stationPane');
    map.getPane('stationPane').style.zIndex=410;
    networkRef.current=L.layerGroup().addTo(map);
    stationRef.current=L.layerGroup().addTo(map);
    reportLayerRef.current=L.layerGroup().addTo(map);pinLayerRef.current=L.layerGroup().addTo(map);
    map.on('click',e=>pinCallback.current?.({lat:e.latlng.lat,lon:e.latlng.lng,confirmed:true}));
    tilesRef.current=makeTiles('roadmap').addTo(map);
    tilesRef.current._aquaMode='roadmap';

    fitRef.current=()=>{
      const points=stationPoints(dataRef.current.stations);
      if(!points.length){map.setView(MUMBAI,12,{animate:false});return}
      if(points.length===1){map.setView(points[0],14,{animate:false});return}
      map.fitBounds(L.latLngBounds(points),{padding:[34,34],maxZoom:13,animate:false,duration:.55});
    };

    const observer=new ResizeObserver(()=>map.invalidateSize({animate:false}));
    observer.observe(canvasRef.current);
    const frame=requestAnimationFrame(()=>map.invalidateSize({animate:false}));

    return()=>{
      cancelAnimationFrame(frame);
      observer.disconnect();
      fitRef.current=null;
      map.stop();
      map.remove();
      mapRef.current=null;
      tilesRef.current=null;
      networkRef.current=null;
      stationRef.current=null;
    };
  },[]);

  useEffect(()=>{
    const map=mapRef.current;
    if(!map)return;
    if(tilesRef.current&&tilesRef.current._aquaMode===mode)return;
    if(tilesRef.current)map.removeLayer(tilesRef.current);
    tilesRef.current=makeTiles(mode).addTo(map);
    tilesRef.current._aquaMode=mode;
    tilesRef.current.bringToBack();
  },[mode]);

  const stationKey=stations.map(s=>`${s.id}:${s.lat??''}:${s.lon??''}:${s.turbidity??''}`).join('|');
  const nodeKey=nodes.map(n=>`${n.id}:${n.parent_id??''}:${n.lat??''}:${n.lon??''}:${n.type??''}`).join('|');

  useEffect(()=>{
    const map=mapRef.current,network=networkRef.current,stationLayer=stationRef.current;
    if(!map||!network||!stationLayer)return;
    network.clearLayers();
    stationLayer.clearLayers();

    const byId=new Map((dataRef.current.nodes||[]).map(n=>[n.id,n]));
    const stationIds=new Set(dataRef.current.stations.map(s=>s.id));

    (dataRef.current.nodes||[]).forEach(n=>{
      if(n.parent_id){
        const parent=byId.get(n.parent_id);
        if(parent&&Number.isFinite(Number(n.lat))&&Number.isFinite(Number(n.lon))&&Number.isFinite(Number(parent.lat))&&Number.isFinite(Number(parent.lon))){
          const local=['building','household'].includes(n.type);
          L.polyline([[Number(parent.lat),Number(parent.lon)],[Number(n.lat),Number(n.lon)]],{
            pane:'networkPane',color:'#5f8577',weight:local?1.2:1.8,opacity:local?.34:.46,dashArray:local?'3 5':null,lineCap:'round'
          }).addTo(network);
        }
      }
      if(!stationIds.has(n.id)&&Number.isFinite(Number(n.lat))&&Number.isFinite(Number(n.lon))){
        const local=['building','household'].includes(n.type);
        const dot=L.circleMarker([Number(n.lat),Number(n.lon)],{
          pane:'networkPane',radius:local?2.3:3.2,color:'#53776a',weight:1,opacity:.75,fillColor:'#ffffff',fillOpacity:.92
        }).addTo(network);
        if(!local)dot.bindTooltip(escapeHtml(n.name),{direction:'top',className:'map-tooltip map-tooltip-mini',opacity:1});
      }
    });

    dataRef.current.stations.forEach((s,index)=>{
      const [lat,lon]=position(s,index);
      const alert=Number(s.turbidity)>5;
      const icon=L.divIcon({
        className:'map-station-wrap',
        html:`<span class="map-station${alert?' is-alert':''}">${DROPLET}</span>`,
        iconSize:[30,30],
        iconAnchor:[15,15]
      });
      const marker=L.marker([lat,lon],{icon,title:s.name,riseOnHover:true,keyboard:true});
      const reading=s.turbidity==null?'No reading':`${s.turbidity} NTU`;
      marker.bindTooltip(
        `<strong>${escapeHtml(s.name)}</strong><span>${escapeHtml(s.area||s.type||'Monitoring station')}</span><em class="${alert?'warn':''}">${alert?'Needs attention':'Within limits'} · ${escapeHtml(reading)}</em>`,
        {direction:'top',offset:[0,-14],className:'map-tooltip',opacity:1}
      );
      marker.on('click',()=>dataRef.current.onSelect?.(s.id));
      marker.addTo(stationLayer);
    });

    const geoKey=stationPoints(dataRef.current.stations).map(p=>p.join(',')).join('|');
    if(geoKey&&geoKey!==lastFitRef.current){
      lastFitRef.current=geoKey;
      fitRef.current?.();
    }
  },[stationKey,nodeKey]);

  const reportKey=JSON.stringify(reports);
  useEffect(()=>{
    const layer=reportLayerRef.current;if(!layer)return;layer.clearLayers();if(!showReports)return;
    const used=new Set();
    reports.forEach((point,index)=>{
      if(used.has(index))return;
      const anchor=L.latLng(point.lat,point.lon);const nearby=reports.map((p,i)=>({p,i})).filter(({p})=>anchor.distanceTo(L.latLng(p.lat,p.lon))<=500);
      const count=nearby.length;if(count>=2){nearby.forEach(({i})=>used.add(i));const hot=count>=5;L.circleMarker(anchor,{radius:Math.min(32,14+count*2),color:hot?'#bf3939':'#c28a3c',weight:1,fillColor:hot?'#e44f45':'#e9b05d',fillOpacity:.25}).bindTooltip(`${count} reports within 500 m · display halo; inspect radius by zooming in`).addTo(layer);L.marker(anchor,{interactive:false,icon:L.divIcon({className:'report-cluster-label',html:`<span class="${hot?'hot':''}">${count}</span>`,iconSize:[24,24],iconAnchor:[12,12]})}).addTo(layer);L.circle(anchor,{radius:500,color:hot?'#bf3939':'#c28a3c',weight:1.5,fillColor:hot?'#e44f45':'#e9b05d',fillOpacity:Math.min(.5,.1+count*.04)}).bindTooltip(`${count} reports within 500 m · geographic cluster, not confirmed contamination`).addTo(layer);}
      else L.circleMarker(anchor,{radius:5,color:'#af6d38',weight:1,fillOpacity:.6}).bindTooltip('1 report · '+(point.confirmed?'user-confirmed pin':'approximate location')).addTo(layer);
    });
  },[reportKey,showReports]);
  const centerKey=JSON.stringify(pickCenter);
  useEffect(()=>{if(pickCenter&&mapRef.current)mapRef.current.setView([pickCenter.lat,pickCenter.lon],15,{animate:false})},[centerKey]);
  const pinKey=JSON.stringify(pin);
  useEffect(()=>{
    const layer=pinLayerRef.current;if(!layer)return;layer.clearLayers();if(!pin)return;
    const marker=L.marker([pin.lat,pin.lon],{draggable:true,icon:L.divIcon({className:'address-pin',html:'<span>Report location</span>',iconSize:[110,28],iconAnchor:[55,28]})}).addTo(layer);
    marker.on('dragend',()=>{const p=marker.getLatLng();pinCallback.current?.({lat:p.lat,lon:p.lng,confirmed:true})});
  },[pinKey]);
  const center=stationPoints(stations)[0]||MUMBAI;
  const link=`https://www.google.com/maps/@${center[0].toFixed(4)},${center[1].toFixed(4)},12z`;

  return <div className={'network-map'+(full?' map-full':'')}>
    <div ref={canvasRef} className="map-canvas" role="application" aria-label="Interactive Google map of the Mumbai water supply network"/>
    <span className="map-caption"><MapPin size={13}/>Mumbai · Google Maps<a href={link} target="_blank" rel="noreferrer" aria-label="Open this area in Google Maps" title="Open in Google Maps"><ExternalLink size={11}/></a></span>
    <button type="button" className="heatmap-toggle" aria-pressed={showReports} onClick={()=>setShowReports(!showReports)}>{showReports?'Hide report density':'Show report density'}</button>
    <div className="map-style-toggle" role="group" aria-label="Base map style">
      <button type="button" className={mode==='roadmap'?'active':''} aria-pressed={mode==='roadmap'} onClick={()=>setMode('roadmap')}>Map</button>
      <button type="button" className={mode==='satellite'?'active':''} aria-pressed={mode==='satellite'} onClick={()=>setMode('satellite')}>Satellite</button>
    </div>
    <button type="button" className="map-fit" onClick={()=>fitRef.current?.()} title="Fit network" aria-label="Fit network to view"><Crosshair size={16}/></button>
  </div>;
}

