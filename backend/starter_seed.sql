BEGIN;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('src_01','source','Upper Vaitarna Lake (simulated)',NULL,19.75,73.35,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('plant_01','plant','Treatment Plant A (simulated)','src_01',19.22,72.97,TRUE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('res_01','reservoir','Service Reservoir 1 (simulated)','plant_01',19.1,72.9,TRUE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('zone_01','zone','K-West Zone (Andheri W), simulated','res_01',19.1364,72.8296,TRUE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('seg_01','street_segment','Street Segment 1','zone_01',19.13724,72.82675,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('bld_01','building_tank','Building 1 Tank','seg_01',19.13679,72.8262,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_01','household','Flat 1','bld_01',19.13693,72.82631,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_02','household','Flat 2','bld_01',19.13703,72.82595,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('bld_02','building_tank','Building 2 Tank','seg_01',19.13708,72.82581,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_03','household','Flat 3','bld_02',19.13691,72.82581,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_04','household','Flat 4','bld_02',19.1368,72.82563,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('seg_02','street_segment','Street Segment 2','zone_01',19.1373,72.82987,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('bld_03','building_tank','Building 3 Tank','seg_02',19.13674,72.83005,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_05','household','Flat 5','bld_03',19.13693,72.82975,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_06','household','Flat 6','bld_03',19.13692,72.83017,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('bld_04','building_tank','Building 4 Tank','seg_02',19.13698,72.82918,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_07','household','Flat 7','bld_04',19.13725,72.82908,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_08','household','Flat 8','bld_04',19.13674,72.82894,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('zone_02','zone','G-North Zone (Dadar), simulated','res_01',19.0178,72.8478,TRUE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('seg_03','street_segment','Street Segment 3','zone_02',19.01988,72.84842,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('bld_05','building_tank','Building 5 Tank','seg_03',19.02049,72.84888,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_09','household','Flat 9','bld_05',19.02051,72.84916,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_10','household','Flat 10','bld_05',19.02042,72.84891,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('bld_06','building_tank','Building 6 Tank','seg_03',19.02054,72.84866,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_11','household','Flat 11','bld_06',19.02076,72.84871,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_12','household','Flat 12','bld_06',19.02066,72.84839,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('seg_04','street_segment','Street Segment 4','zone_02',19.01617,72.84654,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('bld_07','building_tank','Building 7 Tank','seg_04',19.01533,72.84601,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_13','household','Flat 13','bld_07',19.01509,72.84588,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_14','household','Flat 14','bld_07',19.01541,72.84593,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('bld_08','building_tank','Building 8 Tank','seg_04',19.01591,72.84596,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_15','household','Flat 15','bld_08',19.01577,72.84622,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES ('hh_16','household','Flat 16','bld_08',19.016,72.84603,FALSE)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor;
INSERT INTO aquatrace.scenarios VALUES ('background','2026-11-01T00:00:00+05:30','undetermined','manual_review','Older background reports')
                       ON CONFLICT(id) DO NOTHING;
INSERT INTO aquatrace.scenarios VALUES ('S1_plant_fault','2026-11-05T21:00:00+05:30','plant_source','plant_operators','plant turbidity spike + complaints in multiple zones')
                ON CONFLICT(id) DO UPDATE SET as_of=EXCLUDED.as_of,expected_stage=EXCLUDED.expected_stage,
                expected_route=EXCLUDED.expected_route,why=EXCLUDED.why;
INSERT INTO aquatrace.scenarios VALUES ('S2_pipeline_fault','2026-11-06T20:00:00+05:30','distribution_pipeline','bmc','plant normal, several buildings under seg_02 complaining')
                ON CONFLICT(id) DO UPDATE SET as_of=EXCLUDED.as_of,expected_stage=EXCLUDED.expected_stage,
                expected_route=EXCLUDED.expected_route,why=EXCLUDED.why;
INSERT INTO aquatrace.scenarios VALUES ('S3_home_fault','2026-11-07T11:00:00+05:30','household','citizen','plant normal, single household, no neighbors')
                ON CONFLICT(id) DO UPDATE SET as_of=EXCLUDED.as_of,expected_stage=EXCLUDED.expected_stage,
                expected_route=EXCLUDED.expected_route,why=EXCLUDED.why;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T00:00:00+05:30','plant_01',0.666,0.459,7.327,164.107) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T01:00:00+05:30','plant_01',0.81,0.382,7.32,136.705) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T02:00:00+05:30','plant_01',0.734,0.414,7.501,139.838) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T03:00:00+05:30','plant_01',0.694,0.461,7.272,147.168) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T04:00:00+05:30','plant_01',0.9,0.486,7.489,148.399) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T05:00:00+05:30','plant_01',0.633,0.493,7.456,153.279) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T06:00:00+05:30','plant_01',0.511,0.457,7.37,129.315) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T07:00:00+05:30','plant_01',0.56,0.389,7.515,148.245) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T08:00:00+05:30','plant_01',0.779,0.466,7.537,170.639) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T09:00:00+05:30','plant_01',0.445,0.424,7.412,141.113) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T10:00:00+05:30','plant_01',0.624,0.53,7.369,148.313) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T11:00:00+05:30','plant_01',0.648,0.351,7.444,135.653) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T12:00:00+05:30','plant_01',0.52,0.429,7.324,158.608) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T13:00:00+05:30','plant_01',0.671,0.451,7.353,149.605) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T14:00:00+05:30','plant_01',0.624,0.533,7.292,166.037) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T15:00:00+05:30','plant_01',0.906,0.402,7.399,142.979) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T16:00:00+05:30','plant_01',0.628,0.471,7.393,132.484) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T17:00:00+05:30','plant_01',0.41,0.393,7.356,147.993) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T18:00:00+05:30','plant_01',0.475,0.365,7.431,137.397) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T19:00:00+05:30','plant_01',0.461,0.396,7.404,129.808) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T20:00:00+05:30','plant_01',0.66,0.501,7.324,148.533) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T21:00:00+05:30','plant_01',0.44,0.484,7.246,141.845) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T22:00:00+05:30','plant_01',0.509,0.477,7.429,152.612) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T23:00:00+05:30','plant_01',0.687,0.583,7.403,154.734) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T00:00:00+05:30','plant_01',0.486,0.432,7.512,144.366) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T01:00:00+05:30','plant_01',0.541,0.484,7.342,147.74) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T02:00:00+05:30','plant_01',0.422,0.468,7.458,166.427) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T03:00:00+05:30','plant_01',0.449,0.478,7.393,140.549) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T04:00:00+05:30','plant_01',0.597,0.587,7.397,172.268) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T05:00:00+05:30','plant_01',0.691,0.574,7.463,161.509) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T06:00:00+05:30','plant_01',0.734,0.41,7.287,150.798) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T07:00:00+05:30','plant_01',0.676,0.47,7.496,176.866) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T08:00:00+05:30','plant_01',0.602,0.523,7.508,155.098) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T09:00:00+05:30','plant_01',0.689,0.522,7.549,162.369) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T10:00:00+05:30','plant_01',0.729,0.401,7.613,163.548) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T11:00:00+05:30','plant_01',0.684,0.347,7.44,136.564) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T12:00:00+05:30','plant_01',0.664,0.354,7.416,156.62) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T13:00:00+05:30','plant_01',0.47,0.457,7.367,145.223) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T14:00:00+05:30','plant_01',0.716,0.419,7.557,132.056) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T15:00:00+05:30','plant_01',0.581,0.446,7.273,129.675) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T16:00:00+05:30','plant_01',0.738,0.375,7.397,143.163) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T17:00:00+05:30','plant_01',0.528,0.372,7.233,155.427) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T18:00:00+05:30','plant_01',0.777,0.316,7.174,146.961) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T19:00:00+05:30','plant_01',0.454,0.457,7.2,135.617) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T20:00:00+05:30','plant_01',0.749,0.436,7.288,135.498) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T21:00:00+05:30','plant_01',0.558,0.465,7.425,134.494) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T22:00:00+05:30','plant_01',0.461,0.459,7.267,137.457) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T23:00:00+05:30','plant_01',0.395,0.425,7.352,134.696) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T00:00:00+05:30','plant_01',0.599,0.517,7.297,146.575) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T01:00:00+05:30','plant_01',0.841,0.455,7.473,143.307) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T02:00:00+05:30','plant_01',0.699,0.399,7.327,144.66) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T03:00:00+05:30','plant_01',0.694,0.453,7.516,152.942) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T04:00:00+05:30','plant_01',0.302,0.443,7.374,148.335) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T05:00:00+05:30','plant_01',0.729,0.4,7.377,153.432) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T06:00:00+05:30','plant_01',0.617,0.514,7.451,156.543) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T07:00:00+05:30','plant_01',0.63,0.51,7.453,152.306) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T08:00:00+05:30','plant_01',0.583,0.449,7.529,162.182) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T09:00:00+05:30','plant_01',0.558,0.444,7.456,143.168) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T10:00:00+05:30','plant_01',0.844,0.453,7.308,148.907) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T11:00:00+05:30','plant_01',0.499,0.558,7.321,153.072) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T12:00:00+05:30','plant_01',0.584,0.475,7.399,155.241) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T13:00:00+05:30','plant_01',0.79,0.443,7.474,134.897) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T14:00:00+05:30','plant_01',0.551,0.394,7.371,152.04) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T15:00:00+05:30','plant_01',0.508,0.425,7.341,157.35) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T16:00:00+05:30','plant_01',0.577,0.345,7.428,144.622) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T17:00:00+05:30','plant_01',0.4,0.404,7.328,149.841) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T18:00:00+05:30','plant_01',0.555,0.442,7.36,141.545) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T19:00:00+05:30','plant_01',0.379,0.504,7.385,148.207) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T20:00:00+05:30','plant_01',0.68,0.481,7.457,150.177) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T21:00:00+05:30','plant_01',0.521,0.478,7.354,147.702) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T22:00:00+05:30','plant_01',0.823,0.413,7.369,153.665) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T23:00:00+05:30','plant_01',0.646,0.479,7.32,142.711) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T00:00:00+05:30','plant_01',0.74,0.412,7.496,154.226) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T01:00:00+05:30','plant_01',0.458,0.478,7.376,163.818) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T02:00:00+05:30','plant_01',0.633,0.484,7.448,155.735) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T03:00:00+05:30','plant_01',0.68,0.434,7.304,152.301) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T04:00:00+05:30','plant_01',0.863,0.575,7.497,149.322) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T05:00:00+05:30','plant_01',0.406,0.51,7.313,165.452) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T06:00:00+05:30','plant_01',0.796,0.389,7.385,147.702) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T07:00:00+05:30','plant_01',0.649,0.49,7.529,164.97) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T08:00:00+05:30','plant_01',0.824,0.441,7.34,143.599) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T09:00:00+05:30','plant_01',0.682,0.476,7.424,146.547) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T10:00:00+05:30','plant_01',0.655,0.499,7.439,152.024) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T11:00:00+05:30','plant_01',0.517,0.455,7.402,149.358) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T12:00:00+05:30','plant_01',0.443,0.343,7.501,151.223) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T13:00:00+05:30','plant_01',0.543,0.369,7.474,158.951) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T14:00:00+05:30','plant_01',0.527,0.463,7.222,141.627) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T15:00:00+05:30','plant_01',0.841,0.488,7.254,146.919) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T16:00:00+05:30','plant_01',0.507,0.513,7.431,137.562) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T17:00:00+05:30','plant_01',0.584,0.514,7.238,161.8) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T18:00:00+05:30','plant_01',0.395,0.324,7.291,148.027) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T19:00:00+05:30','plant_01',0.48,0.456,7.373,147.846) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T20:00:00+05:30','plant_01',0.63,0.328,7.364,146.123) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T21:00:00+05:30','plant_01',0.57,0.498,7.334,136.777) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T22:00:00+05:30','plant_01',0.737,0.442,7.368,148.734) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T23:00:00+05:30','plant_01',0.625,0.368,7.355,148.86) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T00:00:00+05:30','plant_01',0.437,0.573,7.45,151.533) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T01:00:00+05:30','plant_01',0.623,0.488,7.369,157.623) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T02:00:00+05:30','plant_01',0.658,0.369,7.467,138.146) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T03:00:00+05:30','plant_01',0.665,0.485,7.397,157.999) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T04:00:00+05:30','plant_01',0.525,0.433,7.46,146.909) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T05:00:00+05:30','plant_01',0.778,0.484,7.418,141.597) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T06:00:00+05:30','plant_01',0.676,0.44,7.465,154.105) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T07:00:00+05:30','plant_01',0.686,0.552,7.371,138.551) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T08:00:00+05:30','plant_01',0.838,0.399,7.49,159.498) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T09:00:00+05:30','plant_01',0.673,0.476,7.555,162.101) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T10:00:00+05:30','plant_01',0.642,0.545,7.453,150.461) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T11:00:00+05:30','plant_01',0.834,0.414,7.465,138.146) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T12:00:00+05:30','plant_01',0.659,0.473,7.468,140.939) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T13:00:00+05:30','plant_01',0.571,0.452,7.483,152.163) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T14:00:00+05:30','plant_01',0.591,0.407,7.42,122.249) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T15:00:00+05:30','plant_01',0.702,0.475,7.344,153.636) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T16:00:00+05:30','plant_01',0.602,0.432,7.427,157.568) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T17:00:00+05:30','plant_01',3.439,0.206,7.343,171.266) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T18:00:00+05:30','plant_01',4.934,0.21,7.275,197.614) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T19:00:00+05:30','plant_01',5.714,0.14,7.323,208.118) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T20:00:00+05:30','plant_01',5.738,0.122,7.191,206.076) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T21:00:00+05:30','plant_01',5.316,0.087,7.377,215.966) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T22:00:00+05:30','plant_01',5.606,0.105,7.433,210.386) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T23:00:00+05:30','plant_01',5.573,0.215,7.474,201.023) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T00:00:00+05:30','plant_01',0.529,0.447,7.396,146.592) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T01:00:00+05:30','plant_01',0.542,0.46,7.463,152.066) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T02:00:00+05:30','plant_01',0.669,0.458,7.397,168.204) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T03:00:00+05:30','plant_01',0.633,0.47,7.371,146.417) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T04:00:00+05:30','plant_01',0.554,0.449,7.297,142.608) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T05:00:00+05:30','plant_01',0.682,0.532,7.382,145.345) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T06:00:00+05:30','plant_01',0.799,0.488,7.351,132.818) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T07:00:00+05:30','plant_01',0.599,0.547,7.515,163.44) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T08:00:00+05:30','plant_01',0.722,0.522,7.401,137.376) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T09:00:00+05:30','plant_01',0.634,0.44,7.467,143.802) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T10:00:00+05:30','plant_01',0.873,0.43,7.398,131.259) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T11:00:00+05:30','plant_01',0.426,0.414,7.503,145.228) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T12:00:00+05:30','plant_01',0.73,0.4,7.516,153.838) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T13:00:00+05:30','plant_01',0.55,0.393,7.361,132.205) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T14:00:00+05:30','plant_01',0.579,0.486,7.373,129.372) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T15:00:00+05:30','plant_01',0.829,0.416,7.35,149.304) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T16:00:00+05:30','plant_01',0.505,0.509,7.231,141.191) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T17:00:00+05:30','plant_01',0.794,0.531,7.371,154.564) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T18:00:00+05:30','plant_01',0.456,0.411,7.473,154.161) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T19:00:00+05:30','plant_01',0.62,0.366,7.344,141.946) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T20:00:00+05:30','plant_01',0.528,0.417,7.309,128.896) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T21:00:00+05:30','plant_01',0.526,0.434,7.419,147.566) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T22:00:00+05:30','plant_01',0.531,0.353,7.16,150.589) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T23:00:00+05:30','plant_01',0.523,0.421,7.419,143.76) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T00:00:00+05:30','plant_01',0.647,0.481,7.403,135.865) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T01:00:00+05:30','plant_01',0.38,0.46,7.389,166.465) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T02:00:00+05:30','plant_01',0.902,0.442,7.493,150.99) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T03:00:00+05:30','plant_01',0.623,0.434,7.5,148.167) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T04:00:00+05:30','plant_01',0.867,0.578,7.386,155.144) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T05:00:00+05:30','plant_01',0.507,0.457,7.451,164.148) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T06:00:00+05:30','plant_01',0.661,0.427,7.426,157.606) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T07:00:00+05:30','plant_01',0.989,0.448,7.403,152.713) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T08:00:00+05:30','plant_01',0.501,0.531,7.319,169.335) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T09:00:00+05:30','plant_01',0.422,0.425,7.55,172.299) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T10:00:00+05:30','plant_01',0.589,0.516,7.498,166.896) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T11:00:00+05:30','plant_01',0.651,0.494,7.511,160.706) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T12:00:00+05:30','plant_01',0.651,0.511,7.34,140.236) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T13:00:00+05:30','plant_01',0.718,0.513,7.534,187.629) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T14:00:00+05:30','plant_01',0.533,0.374,7.556,136.088) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T15:00:00+05:30','plant_01',0.411,0.483,7.384,146.092) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T16:00:00+05:30','plant_01',0.518,0.389,7.362,138.164) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T17:00:00+05:30','plant_01',0.707,0.427,7.263,158.316) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T18:00:00+05:30','plant_01',0.554,0.488,7.398,151.427) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T19:00:00+05:30','plant_01',0.268,0.477,7.307,130.607) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T20:00:00+05:30','plant_01',0.554,0.434,7.363,150.272) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T21:00:00+05:30','plant_01',0.693,0.367,7.423,153.827) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T22:00:00+05:30','plant_01',0.849,0.462,7.262,139.646) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T23:00:00+05:30','plant_01',0.685,0.404,7.551,139.85) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T00:00:00+05:30','res_01',0.665,0.433,7.329,165.752) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T01:00:00+05:30','res_01',0.712,0.397,7.34,165.852) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T02:00:00+05:30','res_01',0.821,0.343,7.352,140.032) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T03:00:00+05:30','res_01',0.684,0.355,7.44,142.166) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T04:00:00+05:30','res_01',0.732,0.411,7.283,145.141) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T05:00:00+05:30','res_01',0.738,0.451,7.477,144.68) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T06:00:00+05:30','res_01',0.605,0.456,7.429,152.851) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T07:00:00+05:30','res_01',0.421,0.404,7.41,123.918) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T08:00:00+05:30','res_01',0.566,0.383,7.568,148.031) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T09:00:00+05:30','res_01',0.77,0.369,7.46,177.147) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T10:00:00+05:30','res_01',0.486,0.351,7.392,144.295) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T11:00:00+05:30','res_01',0.636,0.481,7.386,140.79) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T12:00:00+05:30','res_01',0.633,0.281,7.464,136.438) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T13:00:00+05:30','res_01',0.539,0.367,7.311,158.174) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T14:00:00+05:30','res_01',0.65,0.425,7.377,150.255) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T15:00:00+05:30','res_01',0.607,0.473,7.31,170.372) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T16:00:00+05:30','res_01',0.836,0.348,7.371,143.18) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T17:00:00+05:30','res_01',0.623,0.423,7.364,137.487) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T18:00:00+05:30','res_01',0.438,0.338,7.349,154.539) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T19:00:00+05:30','res_01',0.508,0.326,7.471,135.834) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T20:00:00+05:30','res_01',0.477,0.335,7.376,133.693) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T21:00:00+05:30','res_01',0.647,0.462,7.331,155.925) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T22:00:00+05:30','res_01',0.486,0.448,7.283,141.193) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T23:00:00+05:30','res_01',0.616,0.393,7.379,151.723) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T00:00:00+05:30','res_01',0.715,0.56,7.423,157.212) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T01:00:00+05:30','res_01',0.539,0.389,7.534,141.167) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T02:00:00+05:30','res_01',0.558,0.423,7.3,151.978) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T03:00:00+05:30','res_01',0.448,0.414,7.414,166.394) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T04:00:00+05:30','res_01',0.537,0.41,7.442,142.14) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T05:00:00+05:30','res_01',0.533,0.527,7.456,171.532) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T06:00:00+05:30','res_01',0.726,0.457,7.476,150.92) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T07:00:00+05:30','res_01',0.871,0.352,7.314,149.315) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T08:00:00+05:30','res_01',0.615,0.422,7.499,182.969) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T09:00:00+05:30','res_01',0.703,0.455,7.478,155.249) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T10:00:00+05:30','res_01',0.666,0.43,7.513,170.054) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T11:00:00+05:30','res_01',0.71,0.367,7.59,161.646) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T12:00:00+05:30','res_01',0.679,0.302,7.399,137.897) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T13:00:00+05:30','res_01',0.682,0.323,7.402,147.53) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T14:00:00+05:30','res_01',0.513,0.369,7.377,145.664) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T15:00:00+05:30','res_01',0.699,0.404,7.53,129.012) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T16:00:00+05:30','res_01',0.6,0.399,7.218,132.985) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T17:00:00+05:30','res_01',0.695,0.314,7.407,143.25) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T18:00:00+05:30','res_01',0.609,0.314,7.2,154.311) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T19:00:00+05:30','res_01',0.87,0.239,7.165,150.359) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T20:00:00+05:30','res_01',0.515,0.393,7.202,140.033) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T21:00:00+05:30','res_01',0.799,0.372,7.293,142.268) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T22:00:00+05:30','res_01',0.536,0.428,7.484,135.123) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T23:00:00+05:30','res_01',0.507,0.419,7.334,140.125) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T00:00:00+05:30','res_01',0.451,0.391,7.364,135.776) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T01:00:00+05:30','res_01',0.534,0.445,7.279,142.806) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T02:00:00+05:30','res_01',0.758,0.405,7.463,148.585) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T03:00:00+05:30','res_01',0.686,0.367,7.304,139.832) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T04:00:00+05:30','res_01',0.744,0.374,7.541,149.361) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T05:00:00+05:30','res_01',0.446,0.37,7.368,145.726) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T06:00:00+05:30','res_01',0.706,0.325,7.391,151.578) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T07:00:00+05:30','res_01',0.732,0.444,7.491,158.241) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T08:00:00+05:30','res_01',0.635,0.439,7.403,158.18) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T09:00:00+05:30','res_01',0.565,0.395,7.58,157.637) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T10:00:00+05:30','res_01',0.672,0.384,7.463,139.054) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T11:00:00+05:30','res_01',0.849,0.418,7.35,148.778) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T12:00:00+05:30','res_01',0.558,0.501,7.386,151.767) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T13:00:00+05:30','res_01',0.534,0.403,7.326,152.901) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T14:00:00+05:30','res_01',0.747,0.366,7.45,136.077) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T15:00:00+05:30','res_01',0.507,0.366,7.402,148.51) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T16:00:00+05:30','res_01',0.53,0.344,7.357,156.614) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T17:00:00+05:30','res_01',0.535,0.282,7.416,138.251) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T18:00:00+05:30','res_01',0.434,0.361,7.269,142.202) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T19:00:00+05:30','res_01',0.604,0.364,7.332,148.397) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T20:00:00+05:30','res_01',0.402,0.438,7.365,145.967) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T21:00:00+05:30','res_01',0.769,0.418,7.468,155.382) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T22:00:00+05:30','res_01',0.559,0.434,7.336,151.854) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T23:00:00+05:30','res_01',0.826,0.355,7.374,148.111) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T00:00:00+05:30','res_01',0.621,0.435,7.32,137.611) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T01:00:00+05:30','res_01',0.77,0.329,7.437,146.35) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T02:00:00+05:30','res_01',0.5,0.447,7.428,163.656) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T03:00:00+05:30','res_01',0.58,0.421,7.491,145.843) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T04:00:00+05:30','res_01',0.663,0.374,7.325,148.81) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T05:00:00+05:30','res_01',0.892,0.546,7.523,150.812) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T06:00:00+05:30','res_01',0.391,0.456,7.337,154.963) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T07:00:00+05:30','res_01',0.784,0.34,7.347,142.216) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T08:00:00+05:30','res_01',0.692,0.449,7.526,161.06) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T09:00:00+05:30','res_01',0.791,0.41,7.325,144.64) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T10:00:00+05:30','res_01',0.713,0.428,7.425,145.542) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T11:00:00+05:30','res_01',0.635,0.452,7.461,150.178) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T12:00:00+05:30','res_01',0.584,0.454,7.31,152.5) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T13:00:00+05:30','res_01',0.437,0.305,7.52,150.968) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T14:00:00+05:30','res_01',0.658,0.321,7.504,162.402) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T15:00:00+05:30','res_01',0.622,0.416,7.236,144.035) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T16:00:00+05:30','res_01',0.75,0.43,7.22,149.384) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T17:00:00+05:30','res_01',0.468,0.47,7.452,137.839) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T18:00:00+05:30','res_01',0.686,0.458,7.266,159.005) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T19:00:00+05:30','res_01',0.416,0.262,7.339,156.212) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T20:00:00+05:30','res_01',0.478,0.408,7.374,149.231) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T21:00:00+05:30','res_01',0.557,0.306,7.407,152.751) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T22:00:00+05:30','res_01',0.645,0.456,7.366,137.99) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T23:00:00+05:30','res_01',0.716,0.387,7.389,142.228) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T00:00:00+05:30','res_01',0.585,0.301,7.312,153.183) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T01:00:00+05:30','res_01',0.447,0.486,7.482,150.02) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T02:00:00+05:30','res_01',0.721,0.419,7.367,155.463) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T03:00:00+05:30','res_01',0.699,0.319,7.441,138.942) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T04:00:00+05:30','res_01',0.691,0.403,7.377,149.498) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T05:00:00+05:30','res_01',0.606,0.402,7.433,149.825) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T06:00:00+05:30','res_01',0.872,0.425,7.466,145.084) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T07:00:00+05:30','res_01',0.652,0.39,7.424,152.268) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T08:00:00+05:30','res_01',0.649,0.506,7.359,137.642) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T09:00:00+05:30','res_01',0.781,0.4,7.467,158.517) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T10:00:00+05:30','res_01',0.734,0.472,7.525,167.543) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T11:00:00+05:30','res_01',0.626,0.525,7.446,158.656) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T12:00:00+05:30','res_01',0.935,0.357,7.542,137.984) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T13:00:00+05:30','res_01',0.618,0.438,7.449,138.622) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T14:00:00+05:30','res_01',0.556,0.409,7.471,144.958) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T15:00:00+05:30','res_01',0.596,0.36,7.435,124.247) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T16:00:00+05:30','res_01',0.697,0.412,7.367,152.226) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T17:00:00+05:30','res_01',0.511,0.387,7.4,156.13) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T18:00:00+05:30','res_01',3.501,0.177,7.369,171.041) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T19:00:00+05:30','res_01',4.995,0.157,7.29,200.232) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T20:00:00+05:30','res_01',5.567,0.103,7.39,211.348) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T21:00:00+05:30','res_01',5.749,0.064,7.198,211.068) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T22:00:00+05:30','res_01',5.36,0.032,7.38,221.105) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T23:00:00+05:30','res_01',5.544,0.043,7.419,209.852) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T00:00:00+05:30','res_01',5.53,0.146,7.475,202.964) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T01:00:00+05:30','res_01',0.61,0.392,7.379,142.117) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T02:00:00+05:30','res_01',0.546,0.412,7.493,152.031) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T03:00:00+05:30','res_01',0.666,0.406,7.465,168.928) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T04:00:00+05:30','res_01',0.683,0.43,7.366,153.743) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T05:00:00+05:30','res_01',0.596,0.438,7.342,139.895) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T06:00:00+05:30','res_01',0.695,0.475,7.388,144.649) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T07:00:00+05:30','res_01',0.77,0.426,7.371,137.052) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T08:00:00+05:30','res_01',0.586,0.476,7.474,154.825) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T09:00:00+05:30','res_01',0.686,0.475,7.436,142.4) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T10:00:00+05:30','res_01',0.582,0.393,7.508,141.097) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T11:00:00+05:30','res_01',0.85,0.385,7.437,141.594) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T12:00:00+05:30','res_01',0.434,0.366,7.493,140.811) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T13:00:00+05:30','res_01',0.68,0.341,7.507,156.509) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T14:00:00+05:30','res_01',0.451,0.333,7.316,138.535) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T15:00:00+05:30','res_01',0.561,0.451,7.315,126.776) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T16:00:00+05:30','res_01',0.831,0.367,7.297,146.667) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T17:00:00+05:30','res_01',0.528,0.461,7.254,137.497) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T18:00:00+05:30','res_01',0.81,0.485,7.408,151.992) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T19:00:00+05:30','res_01',0.501,0.363,7.418,146.931) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T20:00:00+05:30','res_01',0.58,0.294,7.373,143.952) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T21:00:00+05:30','res_01',0.581,0.354,7.306,133.834) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T22:00:00+05:30','res_01',0.447,0.378,7.402,147.255) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T23:00:00+05:30','res_01',0.585,0.314,7.191,148.681) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T00:00:00+05:30','res_01',0.521,0.403,7.413,141.084) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T01:00:00+05:30','res_01',0.639,0.42,7.458,138.956) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T02:00:00+05:30','res_01',0.375,0.378,7.41,162.016) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T03:00:00+05:30','res_01',0.834,0.358,7.516,147.255) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T04:00:00+05:30','res_01',0.643,0.397,7.541,149.902) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T05:00:00+05:30','res_01',0.882,0.549,7.444,159.298) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T06:00:00+05:30','res_01',0.473,0.41,7.423,157.103) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T07:00:00+05:30','res_01',0.688,0.409,7.406,158.223) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T08:00:00+05:30','res_01',0.997,0.403,7.414,147.91) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T09:00:00+05:30','res_01',0.581,0.445,7.346,159.677) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T10:00:00+05:30','res_01',0.51,0.398,7.496,167.739) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T11:00:00+05:30','res_01',0.523,0.432,7.503,166.469) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T12:00:00+05:30','res_01',0.694,0.424,7.434,158.78) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T13:00:00+05:30','res_01',0.67,0.436,7.297,138.258) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T14:00:00+05:30','res_01',0.795,0.438,7.524,188.151) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T15:00:00+05:30','res_01',0.601,0.354,7.503,129.51) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T16:00:00+05:30','res_01',0.382,0.417,7.432,149.771) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T17:00:00+05:30','res_01',0.513,0.342,7.282,142.096) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T18:00:00+05:30','res_01',0.7,0.352,7.315,163.318) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T19:00:00+05:30','res_01',0.683,0.405,7.37,146.491) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T20:00:00+05:30','res_01',0.347,0.405,7.293,127.392) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T21:00:00+05:30','res_01',0.549,0.409,7.393,142.71) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T22:00:00+05:30','res_01',0.746,0.332,7.44,148.626) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T23:00:00+05:30','res_01',0.854,0.415,7.268,143.841) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T00:00:00+05:30','zone_01',0.776,0.352,7.314,167.212) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T01:00:00+05:30','zone_01',0.719,0.345,7.357,161.293) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T02:00:00+05:30','zone_01',0.692,0.361,7.309,169.067) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T03:00:00+05:30','zone_01',0.699,0.285,7.339,141.548) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T04:00:00+05:30','zone_01',0.741,0.334,7.478,131.69) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T05:00:00+05:30','zone_01',0.742,0.353,7.257,151.435) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T06:00:00+05:30','zone_01',0.818,0.422,7.425,141.511) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T07:00:00+05:30','zone_01',0.584,0.383,7.486,152.74) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T08:00:00+05:30','zone_01',0.535,0.374,7.405,126.279) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T09:00:00+05:30','zone_01',0.62,0.311,7.502,149.091) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T10:00:00+05:30','zone_01',0.762,0.356,7.493,176.032) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T11:00:00+05:30','zone_01',0.465,0.307,7.452,147.833) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T12:00:00+05:30','zone_01',0.636,0.385,7.333,150.973) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T13:00:00+05:30','zone_01',0.634,0.249,7.476,137.707) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T14:00:00+05:30','zone_01',0.603,0.338,7.261,154.071) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T15:00:00+05:30','zone_01',0.695,0.349,7.378,148.595) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T16:00:00+05:30','zone_01',0.643,0.399,7.282,163.535) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T17:00:00+05:30','zone_01',0.785,0.333,7.36,145.771) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T18:00:00+05:30','zone_01',0.663,0.376,7.375,143.622) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T19:00:00+05:30','zone_01',0.516,0.277,7.372,145.246) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T20:00:00+05:30','zone_01',0.454,0.298,7.457,141.932) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T21:00:00+05:30','zone_01',0.458,0.308,7.333,130.862) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T22:00:00+05:30','zone_01',0.673,0.431,7.356,151.805) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T23:00:00+05:30','zone_01',0.469,0.412,7.279,141.698) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T00:00:00+05:30','zone_01',0.651,0.338,7.412,148.461) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T01:00:00+05:30','zone_01',0.642,0.517,7.436,152.801) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T02:00:00+05:30','zone_01',0.581,0.324,7.549,142.423) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T03:00:00+05:30','zone_01',0.63,0.417,7.408,154.938) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T04:00:00+05:30','zone_01',0.362,0.385,7.426,164.588) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T05:00:00+05:30','zone_01',0.532,0.346,7.465,145.353) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T06:00:00+05:30','zone_01',0.565,0.492,7.43,170.332) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T07:00:00+05:30','zone_01',0.81,0.44,7.45,155.376) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T08:00:00+05:30','zone_01',0.779,0.301,7.281,150.91) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T09:00:00+05:30','zone_01',0.672,0.366,7.478,180.613) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T10:00:00+05:30','zone_01',0.685,0.392,7.463,155.71) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T11:00:00+05:30','zone_01',0.624,0.412,7.527,166.225) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T12:00:00+05:30','zone_01',0.787,0.297,7.618,161.931) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T13:00:00+05:30','zone_01',0.756,0.231,7.379,137.254) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T14:00:00+05:30','zone_01',0.638,0.272,7.415,149.874) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T15:00:00+05:30','zone_01',0.497,0.335,7.411,149.014) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T16:00:00+05:30','zone_01',0.723,0.364,7.493,132.437) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T17:00:00+05:30','zone_01',0.601,0.34,7.235,127.643) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T18:00:00+05:30','zone_01',0.744,0.3,7.405,143.656) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T19:00:00+05:30','zone_01',0.568,0.27,7.243,151.163) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T20:00:00+05:30','zone_01',0.835,0.211,7.135,150.908) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T21:00:00+05:30','zone_01',0.528,0.35,7.183,138.168) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T22:00:00+05:30','zone_01',0.703,0.336,7.265,140.061) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T23:00:00+05:30','zone_01',0.513,0.386,7.448,133.47) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T00:00:00+05:30','zone_01',0.592,0.378,7.325,149.651) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T01:00:00+05:30','zone_01',0.431,0.327,7.405,134.452) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T02:00:00+05:30','zone_01',0.585,0.418,7.33,149.183) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T03:00:00+05:30','zone_01',0.751,0.366,7.482,147.912) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T04:00:00+05:30','zone_01',0.698,0.324,7.309,146.734) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T05:00:00+05:30','zone_01',0.706,0.341,7.516,150.031) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T06:00:00+05:30','zone_01',0.412,0.358,7.325,143.758) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T07:00:00+05:30','zone_01',0.756,0.263,7.374,152.203) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T08:00:00+05:30','zone_01',0.669,0.389,7.451,163.492) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T09:00:00+05:30','zone_01',0.58,0.377,7.467,160.649) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T10:00:00+05:30','zone_01',0.542,0.332,7.546,155.002) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T11:00:00+05:30','zone_01',0.694,0.315,7.437,141.436) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T12:00:00+05:30','zone_01',0.863,0.376,7.31,148.169) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T13:00:00+05:30','zone_01',0.478,0.466,7.364,150.012) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T14:00:00+05:30','zone_01',0.584,0.367,7.349,158.728) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T15:00:00+05:30','zone_01',0.752,0.299,7.443,129.292) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T16:00:00+05:30','zone_01',0.499,0.291,7.414,149.651) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T17:00:00+05:30','zone_01',0.473,0.312,7.355,159.922) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T18:00:00+05:30','zone_01',0.571,0.228,7.457,149.201) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T19:00:00+05:30','zone_01',0.46,0.323,7.326,142.26) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T20:00:00+05:30','zone_01',0.583,0.306,7.342,145.215) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T21:00:00+05:30','zone_01',0.428,0.408,7.385,148.189) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T22:00:00+05:30','zone_01',0.646,0.384,7.451,151.622) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T23:00:00+05:30','zone_01',0.546,0.392,7.355,147.999) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T00:00:00+05:30','zone_01',0.868,0.264,7.325,149.373) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T01:00:00+05:30','zone_01',0.657,0.384,7.335,140.217) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T02:00:00+05:30','zone_01',0.768,0.286,7.444,145.804) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T03:00:00+05:30','zone_01',0.437,0.371,7.35,163.905) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T04:00:00+05:30','zone_01',0.545,0.392,7.457,151.797) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T05:00:00+05:30','zone_01',0.657,0.325,7.307,151.386) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T06:00:00+05:30','zone_01',0.924,0.455,7.521,146.033) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T07:00:00+05:30','zone_01',0.418,0.395,7.33,165.05) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T08:00:00+05:30','zone_01',0.728,0.294,7.353,145.237) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T09:00:00+05:30','zone_01',0.767,0.414,7.54,165.825) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T10:00:00+05:30','zone_01',0.848,0.365,7.37,141.845) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T11:00:00+05:30','zone_01',0.718,0.381,7.447,144.632) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T12:00:00+05:30','zone_01',0.678,0.381,7.399,158.377) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T13:00:00+05:30','zone_01',0.55,0.369,7.334,151.299) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T14:00:00+05:30','zone_01',0.486,0.261,7.515,154.598) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T15:00:00+05:30','zone_01',0.612,0.3,7.45,155.827) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T16:00:00+05:30','zone_01',0.551,0.367,7.194,145.235) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T17:00:00+05:30','zone_01',0.772,0.397,7.252,151.067) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T18:00:00+05:30','zone_01',0.454,0.416,7.451,138.202) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T19:00:00+05:30','zone_01',0.625,0.41,7.207,156.363) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T20:00:00+05:30','zone_01',0.356,0.237,7.346,152.599) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T21:00:00+05:30','zone_01',0.473,0.361,7.356,149.805) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T22:00:00+05:30','zone_01',0.544,0.235,7.411,149.962) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T23:00:00+05:30','zone_01',0.611,0.393,7.434,135.968) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T00:00:00+05:30','zone_01',0.759,0.354,7.359,149.409) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T01:00:00+05:30','zone_01',0.579,0.287,7.369,151.351) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T02:00:00+05:30','zone_01',0.448,0.445,7.47,150.636) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T03:00:00+05:30','zone_01',0.685,0.393,7.389,155.129) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T04:00:00+05:30','zone_01',0.699,0.267,7.481,136.812) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T05:00:00+05:30','zone_01',0.745,0.383,7.413,160.826) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T06:00:00+05:30','zone_01',0.478,0.337,7.442,152.533) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T07:00:00+05:30','zone_01',0.77,0.425,7.398,145.045) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T08:00:00+05:30','zone_01',0.647,0.364,7.423,152.1) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T09:00:00+05:30','zone_01',0.667,0.449,7.331,132.336) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T10:00:00+05:30','zone_01',0.799,0.303,7.532,157.256) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T11:00:00+05:30','zone_01',0.724,0.392,7.541,159.645) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T12:00:00+05:30','zone_01',0.657,0.469,7.435,154.508) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T13:00:00+05:30','zone_01',0.861,0.342,7.472,140.83) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T14:00:00+05:30','zone_01',0.571,0.339,7.476,139.864) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T15:00:00+05:30','zone_01',0.562,0.342,7.458,145.324) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T16:00:00+05:30','zone_01',0.599,0.297,7.444,121.198) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T17:00:00+05:30','zone_01',0.783,0.345,7.37,145.745) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T18:00:00+05:30','zone_01',0.616,0.335,7.429,153.018) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T19:00:00+05:30','zone_01',3.434,0.145,7.391,171.949) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T20:00:00+05:30','zone_01',4.971,0.118,7.268,199.455) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T21:00:00+05:30','zone_01',5.639,0.055,7.342,209.18) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T22:00:00+05:30','zone_01',5.733,0.009,7.191,204.678) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T23:00:00+05:30','zone_01',5.395,0.005,7.385,215.816) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T00:00:00+05:30','zone_01',5.631,0.0,7.443,207.644) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T01:00:00+05:30','zone_01',5.543,0.096,7.488,202.483) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T02:00:00+05:30','zone_01',0.648,0.366,7.414,149.044) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T03:00:00+05:30','zone_01',0.426,0.374,7.493,155.775) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T04:00:00+05:30','zone_01',0.703,0.355,7.414,165.663) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T05:00:00+05:30','zone_01',0.762,0.419,7.385,150.365) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T06:00:00+05:30','zone_01',0.555,0.379,7.33,143.421) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T07:00:00+05:30','zone_01',0.695,0.408,7.35,145.401) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T08:00:00+05:30','zone_01',0.722,0.38,7.361,131.728) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T09:00:00+05:30','zone_01',0.497,0.426,7.505,158.189) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T10:00:00+05:30','zone_01',0.641,0.381,7.468,140.068) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T11:00:00+05:30','zone_01',0.654,0.364,7.491,137.366) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T12:00:00+05:30','zone_01',0.881,0.302,7.405,130.613) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T13:00:00+05:30','zone_01',0.324,0.304,7.479,136.556) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T14:00:00+05:30','zone_01',0.679,0.313,7.465,161.72) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T15:00:00+05:30','zone_01',0.576,0.31,7.328,138.273) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T16:00:00+05:30','zone_01',0.591,0.363,7.337,138.749) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T17:00:00+05:30','zone_01',0.778,0.334,7.317,150.741) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T18:00:00+05:30','zone_01',0.52,0.387,7.254,142.854) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T19:00:00+05:30','zone_01',0.731,0.435,7.401,151.624) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T20:00:00+05:30','zone_01',0.509,0.326,7.447,153.277) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T21:00:00+05:30','zone_01',0.552,0.231,7.331,141.062) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T22:00:00+05:30','zone_01',0.526,0.321,7.332,130.889) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T23:00:00+05:30','zone_01',0.462,0.318,7.479,146.806) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T00:00:00+05:30','zone_01',0.645,0.246,7.182,148.721) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T01:00:00+05:30','zone_01',0.502,0.327,7.393,141.338) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T02:00:00+05:30','zone_01',0.569,0.367,7.405,138.37) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T03:00:00+05:30','zone_01',0.38,0.315,7.377,160.524) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T04:00:00+05:30','zone_01',0.92,0.326,7.524,147.128) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T05:00:00+05:30','zone_01',0.561,0.352,7.564,144.254) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T06:00:00+05:30','zone_01',0.843,0.464,7.408,158.142) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T07:00:00+05:30','zone_01',0.572,0.367,7.491,165.233) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T08:00:00+05:30','zone_01',0.676,0.343,7.401,161.996) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T09:00:00+05:30','zone_01',1.05,0.355,7.403,148.774) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T10:00:00+05:30','zone_01',0.548,0.404,7.339,159.6) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T11:00:00+05:30','zone_01',0.476,0.353,7.565,174.638) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T12:00:00+05:30','zone_01',0.534,0.385,7.507,167.842) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T13:00:00+05:30','zone_01',0.649,0.38,7.481,162.099) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T14:00:00+05:30','zone_01',0.751,0.399,7.289,143.003) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T15:00:00+05:30','zone_01',0.711,0.401,7.564,182.086) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T16:00:00+05:30','zone_01',0.573,0.307,7.543,133.043) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T17:00:00+05:30','zone_01',0.403,0.393,7.371,145.582) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T18:00:00+05:30','zone_01',0.409,0.29,7.282,136.286) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T19:00:00+05:30','zone_01',0.707,0.309,7.265,161.081) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T20:00:00+05:30','zone_01',0.604,0.386,7.413,147.811) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T21:00:00+05:30','zone_01',0.364,0.343,7.286,125.74) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T22:00:00+05:30','zone_01',0.555,0.335,7.403,148.494) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T23:00:00+05:30','zone_01',0.705,0.285,7.453,152.229) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T00:00:00+05:30','zone_02',0.725,0.362,7.285,165.822) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T01:00:00+05:30','zone_02',0.692,0.329,7.287,165.467) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T02:00:00+05:30','zone_02',0.676,0.335,7.323,164.614) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T03:00:00+05:30','zone_02',0.693,0.369,7.325,171.308) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T04:00:00+05:30','zone_02',0.828,0.29,7.344,138.043) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T05:00:00+05:30','zone_02',0.653,0.309,7.443,139.689) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T06:00:00+05:30','zone_02',0.747,0.356,7.257,147.782) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T07:00:00+05:30','zone_02',0.799,0.392,7.468,143.839) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T08:00:00+05:30','zone_02',0.668,0.395,7.427,151.951) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T09:00:00+05:30','zone_02',0.448,0.335,7.413,130.716) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T10:00:00+05:30','zone_02',0.644,0.294,7.524,154.265) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T11:00:00+05:30','zone_02',0.792,0.302,7.509,174.355) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T12:00:00+05:30','zone_02',0.457,0.289,7.404,143.651) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T13:00:00+05:30','zone_02',0.643,0.366,7.33,149.487) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T14:00:00+05:30','zone_02',0.634,0.229,7.45,138.302) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T15:00:00+05:30','zone_02',0.577,0.302,7.301,155.354) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T16:00:00+05:30','zone_02',0.649,0.348,7.36,143.738) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T17:00:00+05:30','zone_02',0.667,0.391,7.306,161.645) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T18:00:00+05:30','zone_02',0.859,0.314,7.373,152.663) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T19:00:00+05:30','zone_02',0.541,0.373,7.406,139.008) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T20:00:00+05:30','zone_02',0.515,0.269,7.33,150.369) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T21:00:00+05:30','zone_02',0.548,0.268,7.442,142.595) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T22:00:00+05:30','zone_02',0.43,0.29,7.408,133.065) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-01T23:00:00+05:30','zone_02',0.643,0.396,7.339,150.62) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T00:00:00+05:30','zone_02',0.538,0.365,7.246,149.187) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T01:00:00+05:30','zone_02',0.577,0.344,7.448,150.098) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T02:00:00+05:30','zone_02',0.704,0.492,7.425,150.81) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T03:00:00+05:30','zone_02',0.495,0.324,7.54,143.886) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T04:00:00+05:30','zone_02',0.574,0.367,7.366,157.457) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T05:00:00+05:30','zone_02',0.475,0.339,7.422,171.596) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T06:00:00+05:30','zone_02',0.445,0.366,7.428,140.076) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T07:00:00+05:30','zone_02',0.61,0.439,7.441,168.73) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T08:00:00+05:30','zone_02',0.698,0.44,7.468,153.636) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T09:00:00+05:30','zone_02',0.868,0.291,7.305,151.012) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T10:00:00+05:30','zone_02',0.644,0.345,7.42,180.462) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T11:00:00+05:30','zone_02',0.672,0.371,7.48,158.59) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T12:00:00+05:30','zone_02',0.582,0.438,7.553,168.349) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T13:00:00+05:30','zone_02',0.824,0.282,7.583,163.757) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T14:00:00+05:30','zone_02',0.661,0.234,7.416,136.093) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T15:00:00+05:30','zone_02',0.581,0.238,7.394,148.982) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T16:00:00+05:30','zone_02',0.383,0.301,7.376,146.829) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T17:00:00+05:30','zone_02',0.783,0.323,7.511,132.819) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T18:00:00+05:30','zone_02',0.649,0.335,7.236,129.462) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T19:00:00+05:30','zone_02',0.747,0.299,7.396,147.169) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T20:00:00+05:30','zone_02',0.566,0.233,7.181,152.554) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T21:00:00+05:30','zone_02',0.758,0.219,7.148,153.399) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T22:00:00+05:30','zone_02',0.478,0.334,7.151,144.925) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-02T23:00:00+05:30','zone_02',0.739,0.337,7.238,139.732) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T00:00:00+05:30','zone_02',0.597,0.364,7.461,141.637) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T01:00:00+05:30','zone_02',0.493,0.376,7.297,145.569) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T02:00:00+05:30','zone_02',0.536,0.301,7.317,138.867) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T03:00:00+05:30','zone_02',0.557,0.39,7.299,146.366) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T04:00:00+05:30','zone_02',0.835,0.348,7.49,158.002) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T05:00:00+05:30','zone_02',0.695,0.275,7.385,144.292) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T06:00:00+05:30','zone_02',0.716,0.298,7.508,153.291) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T07:00:00+05:30','zone_02',0.353,0.294,7.341,149.874) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T08:00:00+05:30','zone_02',0.78,0.254,7.455,157.865) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T09:00:00+05:30','zone_02',0.782,0.388,7.48,156.053) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T10:00:00+05:30','zone_02',0.525,0.36,7.456,156.614) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T11:00:00+05:30','zone_02',0.582,0.338,7.569,162.014) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T12:00:00+05:30','zone_02',0.635,0.311,7.382,139.632) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T13:00:00+05:30','zone_02',0.804,0.35,7.349,151.468) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T14:00:00+05:30','zone_02',0.511,0.438,7.342,153.374) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T15:00:00+05:30','zone_02',0.529,0.358,7.375,155.68) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T16:00:00+05:30','zone_02',0.781,0.302,7.442,134.127) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T17:00:00+05:30','zone_02',0.552,0.283,7.376,150.156) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T18:00:00+05:30','zone_02',0.511,0.288,7.337,157.78) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T19:00:00+05:30','zone_02',0.569,0.249,7.421,145.233) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T20:00:00+05:30','zone_02',0.389,0.303,7.319,145.93) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T21:00:00+05:30','zone_02',0.628,0.299,7.301,149.271) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T22:00:00+05:30','zone_02',0.436,0.394,7.374,142.474) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-03T23:00:00+05:30','zone_02',0.633,0.359,7.498,150.165) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T00:00:00+05:30','zone_02',0.578,0.35,7.329,147.402) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T01:00:00+05:30','zone_02',0.857,0.285,7.364,154.056) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T02:00:00+05:30','zone_02',0.655,0.35,7.326,136.479) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T03:00:00+05:30','zone_02',0.768,0.289,7.471,150.78) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T04:00:00+05:30','zone_02',0.525,0.342,7.385,163.545) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T05:00:00+05:30','zone_02',0.65,0.368,7.471,155.099) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T06:00:00+05:30','zone_02',0.697,0.31,7.274,149.768) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T07:00:00+05:30','zone_02',0.89,0.476,7.521,143.987) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T08:00:00+05:30','zone_02',0.424,0.394,7.319,156.826) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T09:00:00+05:30','zone_02',0.753,0.234,7.396,145.25) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T10:00:00+05:30','zone_02',0.721,0.406,7.511,157.491) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T11:00:00+05:30','zone_02',0.826,0.343,7.302,143.855) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T12:00:00+05:30','zone_02',0.708,0.352,7.414,150.948) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T13:00:00+05:30','zone_02',0.622,0.371,7.419,146.63) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T14:00:00+05:30','zone_02',0.6,0.31,7.366,148.632) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T15:00:00+05:30','zone_02',0.401,0.226,7.56,153.934) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T16:00:00+05:30','zone_02',0.604,0.253,7.523,158.221) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T17:00:00+05:30','zone_02',0.578,0.324,7.23,144.329) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T18:00:00+05:30','zone_02',0.758,0.358,7.245,149.435) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T19:00:00+05:30','zone_02',0.494,0.378,7.4,142.914) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T20:00:00+05:30','zone_02',0.56,0.385,7.243,156.927) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T21:00:00+05:30','zone_02',0.405,0.189,7.339,148.758) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T22:00:00+05:30','zone_02',0.532,0.336,7.358,150.27) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-04T23:00:00+05:30','zone_02',0.608,0.19,7.389,153.66) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T00:00:00+05:30','zone_02',0.682,0.384,7.362,138.428) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T01:00:00+05:30','zone_02',0.668,0.33,7.38,145.274) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T02:00:00+05:30','zone_02',0.554,0.262,7.352,153.271) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T03:00:00+05:30','zone_02',0.45,0.436,7.494,153.012) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T04:00:00+05:30','zone_02',0.662,0.375,7.356,148.788) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T05:00:00+05:30','zone_02',0.713,0.254,7.467,141.112) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T06:00:00+05:30','zone_02',0.641,0.368,7.346,156.905) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T07:00:00+05:30','zone_02',0.52,0.326,7.469,145.792) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T08:00:00+05:30','zone_02',0.783,0.383,7.395,145.927) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T09:00:00+05:30','zone_02',0.665,0.351,7.397,153.464) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T10:00:00+05:30','zone_02',0.772,0.448,7.349,135.426) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T11:00:00+05:30','zone_02',0.862,0.264,7.506,161.848) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T12:00:00+05:30','zone_02',0.715,0.353,7.572,164.721) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T13:00:00+05:30','zone_02',0.725,0.424,7.433,155.255) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T14:00:00+05:30','zone_02',0.937,0.296,7.435,140.708) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T15:00:00+05:30','zone_02',0.664,0.351,7.494,146.321) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T16:00:00+05:30','zone_02',0.536,0.319,7.432,146.826) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T17:00:00+05:30','zone_02',0.625,0.306,7.405,123.307) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T18:00:00+05:30','zone_02',0.738,0.36,7.363,147.954) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T19:00:00+05:30','zone_02',0.568,0.308,7.469,149.638) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T20:00:00+05:30','zone_02',3.561,0.094,7.338,170.069) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T21:00:00+05:30','zone_02',4.994,0.088,7.299,197.585) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T22:00:00+05:30','zone_02',5.596,0.035,7.36,202.581) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-05T23:00:00+05:30','zone_02',5.741,0.004,7.186,206.704) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T00:00:00+05:30','zone_02',5.3,0.0,7.375,225.649) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T01:00:00+05:30','zone_02',5.62,0.0,7.371,207.353) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T02:00:00+05:30','zone_02',5.602,0.094,7.473,204.813) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T03:00:00+05:30','zone_02',0.644,0.345,7.387,146.7) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T04:00:00+05:30','zone_02',0.477,0.349,7.457,152.328) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T05:00:00+05:30','zone_02',0.636,0.347,7.425,165.469) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T06:00:00+05:30','zone_02',0.711,0.405,7.362,148.582) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T07:00:00+05:30','zone_02',0.564,0.349,7.314,138.67) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T08:00:00+05:30','zone_02',0.683,0.416,7.351,140.338) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T09:00:00+05:30','zone_02',0.769,0.367,7.299,134.607) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T10:00:00+05:30','zone_02',0.578,0.409,7.512,159.952) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T11:00:00+05:30','zone_02',0.632,0.399,7.46,140.052) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T12:00:00+05:30','zone_02',0.649,0.33,7.512,139.345) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T13:00:00+05:30','zone_02',0.956,0.296,7.447,131.14) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T14:00:00+05:30','zone_02',0.457,0.261,7.505,133.876) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T15:00:00+05:30','zone_02',0.64,0.321,7.507,149.653) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T16:00:00+05:30','zone_02',0.55,0.264,7.349,141.144) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T17:00:00+05:30','zone_02',0.587,0.365,7.365,126.726) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T18:00:00+05:30','zone_02',0.818,0.32,7.307,146.32) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T19:00:00+05:30','zone_02',0.608,0.386,7.2,140.986) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T20:00:00+05:30','zone_02',0.804,0.414,7.404,148.744) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T21:00:00+05:30','zone_02',0.557,0.314,7.481,147.322) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T22:00:00+05:30','zone_02',0.598,0.241,7.369,143.047) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-06T23:00:00+05:30','zone_02',0.471,0.299,7.312,134.637) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T00:00:00+05:30','zone_02',0.487,0.303,7.455,142.738) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T01:00:00+05:30','zone_02',0.644,0.249,7.221,150.915) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T02:00:00+05:30','zone_02',0.534,0.305,7.381,144.91) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T03:00:00+05:30','zone_02',0.65,0.337,7.404,136.755) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T04:00:00+05:30','zone_02',0.333,0.309,7.405,160.08) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T05:00:00+05:30','zone_02',0.847,0.344,7.485,144.794) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T06:00:00+05:30','zone_02',0.68,0.307,7.525,155.802) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T07:00:00+05:30','zone_02',0.827,0.436,7.432,154.262) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T08:00:00+05:30','zone_02',0.509,0.349,7.409,166.532) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T09:00:00+05:30','zone_02',0.715,0.316,7.414,159.283) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T10:00:00+05:30','zone_02',1.009,0.336,7.406,155.913) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T11:00:00+05:30','zone_02',0.537,0.402,7.335,160.0) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T12:00:00+05:30','zone_02',0.421,0.303,7.566,173.298) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T13:00:00+05:30','zone_02',0.563,0.362,7.475,164.984) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T14:00:00+05:30','zone_02',0.72,0.368,7.461,156.739) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T15:00:00+05:30','zone_02',0.671,0.371,7.303,138.484) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T16:00:00+05:30','zone_02',0.724,0.398,7.561,186.862) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T17:00:00+05:30','zone_02',0.567,0.286,7.563,136.912) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T18:00:00+05:30','zone_02',0.426,0.364,7.386,140.7) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T19:00:00+05:30','zone_02',0.505,0.277,7.276,143.148) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T20:00:00+05:30','zone_02',0.701,0.305,7.257,160.609) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T21:00:00+05:30','zone_02',0.588,0.375,7.399,148.973) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T22:00:00+05:30','zone_02',0.3,0.342,7.296,133.406) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES ('2026-11-07T23:00:00+05:30','zone_02',0.55,0.297,7.356,148.734) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-014','hh_08','cloudy','Cloudy water, clears slowly in the glass.','all','2026-11-01T05:09:00+05:30','2026-11-01T06:00:00+05:30',FALSE,FALSE,'background',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-013','hh_15','bad_taste','Water tastes metallic.','all','2026-11-03T08:00:00+05:30','2026-11-03T09:00:00+05:30',FALSE,FALSE,'background',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-011','hh_16','cloudy','Cloudy water, clears slowly in the glass.','all','2026-11-04T06:55:00+05:30','2026-11-04T08:00:00+05:30',FALSE,FALSE,'background',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-012','hh_01','bad_taste','Water tastes metallic.','single_tap','2026-11-04T10:26:00+05:30','2026-11-04T11:00:00+05:30',FALSE,FALSE,'background',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-004','hh_13','cloudy','Water looks milky and cloudy.','all','2026-11-05T17:56:00+05:30','2026-11-05T19:03:00+05:30',TRUE,FALSE,'S1_plant_fault',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-005','hh_15','brown_discolored','Water coming out brown since evening.','all','2026-11-05T18:17:00+05:30','2026-11-05T19:28:00+05:30',TRUE,FALSE,'S1_plant_fault',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-001','hh_01','cloudy','Cloudy water, clears slowly in the glass.','all','2026-11-05T18:27:00+05:30','2026-11-05T19:41:00+05:30',TRUE,FALSE,'S1_plant_fault',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-003','hh_10','brown_discolored','Tap water is yellowish-brown, looks like rust.','all','2026-11-05T19:15:00+05:30','2026-11-05T20:20:00+05:30',TRUE,FALSE,'S1_plant_fault',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-002','hh_06','brown_discolored','Water coming out brown since evening.','all','2026-11-05T20:05:00+05:30','2026-11-05T20:26:00+05:30',TRUE,FALSE,'S1_plant_fault',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-008','hh_07','brown_discolored','Water coming out brown since evening.','all','2026-11-06T17:58:00+05:30','2026-11-06T18:32:00+05:30',TRUE,FALSE,'S2_pipeline_fault',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-006','hh_05','brown_discolored','Tap water is yellowish-brown, looks like rust.','all','2026-11-06T18:10:00+05:30','2026-11-06T19:04:00+05:30',TRUE,FALSE,'S2_pipeline_fault',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-007','hh_06','brown_discolored','Tap water is yellowish-brown, looks like rust.','all','2026-11-06T17:53:00+05:30','2026-11-06T19:06:00+05:30',TRUE,FALSE,'S2_pipeline_fault',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-009','hh_08','brown_discolored','Water coming out brown since evening.','all','2026-11-06T18:59:00+05:30','2026-11-06T19:39:00+05:30',TRUE,FALSE,'S2_pipeline_fault',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES ('C-010','hh_09','particles','Small particles floating in the water.','single_tap','2026-11-07T09:17:00+05:30','2026-11-07T10:30:00+05:30',FALSE,FALSE,'S3_home_fault',true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_01','Vijay Jadhav','+91 90000 00010',19.14033,72.83299,'tank cleaning') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_02','Ramesh Yadav','+91 90000 00011',19.01793,72.84706,'pipe repair') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_03','Suresh Pawar','+91 90000 00012',19.1321,72.82554,'pipe repair') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_04','Rafiq Gupta','+91 90000 00013',19.01548,72.84144,'general plumbing') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_05','Suresh Pawar','+91 90000 00014',19.13513,72.82045,'tank cleaning') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_06','Suresh Gupta','+91 90000 00015',19.0157,72.84917,'tank cleaning') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_07','Mahesh Khan','+91 90000 00016',19.14576,72.8311,'general plumbing') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_08','Salim Jadhav','+91 90000 00017',19.02561,72.8554,'filter install') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_09','Rafiq Pawar','+91 90000 00018',19.1416,72.82632,'tank cleaning') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_10','Santosh More','+91 90000 00019',19.00585,72.84432,'filter install') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_11','Rafiq Jadhav','+91 90000 00020',19.14125,72.8187,'pipe repair') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES ('pl_12','Nitin Gupta','+91 90000 00021',19.00837,72.85046,'general plumbing') ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty;
COMMIT;