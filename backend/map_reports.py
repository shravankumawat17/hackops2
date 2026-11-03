from pathlib import Path
p=Path('frontend/src/MapView.jsx');s=p.read_text().replace('onSelect,full=false})','onSelect,full=false,reports=[],pickCenter=null,pin=null,onPinChange=null})')
s=s.replace('const fitRef=useRef(null);','const fitRef=useRef(null);\n  const reportLayerRef=useRef(null),pinLayerRef=useRef(null),pinCallback=useRef(onPinChange);pinCallback.current=onPinChange;\n  const [showReports,setShowReports]=useState(true);')
s=s.replace("stationRef.current=L.layerGroup().addTo(map);", "stationRef.current=L.layerGroup().addTo(map);\n    reportLayerRef.current=L.layerGroup().addTo(map);pinLayerRef.current=L.layerGroup().addTo(map);\n    map.on('click',e=>pinCallback.current?.({lat:e.latlng.lat,lon:e.latlng.lng,confirmed:true}));")
needle='  const center=stationPoints(stations)[0]||MUMBAI;'
extra='''  const reportKey=JSON.stringify(reports);
  useEffect(()=>{
    const layer=reportLayerRef.current;if(!layer)return;layer.clearLayers();if(!showReports)return;
    const used=new Set();
    reports.forEach((point,index)=>{
      if(used.has(index))return;
      const anchor=L.latLng(point.lat,point.lon);const nearby=reports.map((p,i)=>({p,i})).filter(({p})=>anchor.distanceTo(L.latLng(p.lat,p.lon))<=500);
      const count=nearby.length;if(count>=2){nearby.forEach(({i})=>used.add(i));const hot=count>=5;L.circle(anchor,{radius:500,color:hot?'#bf3939':'#c28a3c',weight:1.5,fillColor:hot?'#e44f45':'#e9b05d',fillOpacity:Math.min(.5,.1+count*.04)}).bindTooltip(`${count} reports within 500 m · geographic cluster, not confirmed contamination`).addTo(layer);}
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
'''
s=s.replace(needle,extra+needle)
s=s.replace('<div className="map-style-toggle"', '<button type="button" className="heatmap-toggle" aria-pressed={showReports} onClick={()=>setShowReports(!showReports)}>{showReports?\'Hide report density\':\'Show report density\'}</button>\n    <div className="map-style-toggle"')
p.write_text(s)
