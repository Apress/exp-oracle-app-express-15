-- Gas Stations Sample Objects and Data

-- Create gas stations table
CREATE TABLE  gas_stations (
  id    NUMBER NOT NULL ENABLE, 
  name  VARCHAR2(30) NOT NULL ENABLE, 
  brand VARCHAR2(30), 
  lat   VARCHAR2(30), 
  lng   VARCHAR2(30), 
  geom  SDO_GEOMETRY, 
  CONSTRAINT gas_stations_pk PRIMARY KEY (ID)
  USING INDEX  ENABLE
   )
/

-- Add sample data
INSERT INTO gas_stations(id,name,brand,lat,lng) 
VALUES (1,'Hall-Johnson','Exxon','32.894146491759976','-97.10038661956787');

INSERT INTO gas_stations(id,name,brand,lat,lng) 
VALUES (2,'Davo Shell','Exxon','32.91158569379285','-97.09038734436035');

INSERT INTO gas_stations(id,name,brand,lat,lng) 
VALUES (3,'William D Tate','Exxon','32.91990773851293','-97.08577394485474');

INSERT INTO gas_stations(id,name,brand,lat,lng) 
VALUES (4,'Texaco Icebox','Texaco','32.93795415942737','-97.08094596862793');

INSERT INTO gas_stations(id,name,brand,lat,lng) 
VALUES (5,'Gate Way Ten','Shell','32.944725119912576','-97.1165657043457');

INSERT INTO gas_stations(id,name,brand,lat,lng) 
VALUES (6,'Mustang Ct','Conoco','32.91936736975364','-97.11922645568848');

INSERT INTO gas_stations(id,name,brand,lat,lng) 
VALUES (7,'Shell Quik Mart','Shell','32.852191873964635','-97.0825767517089');

INSERT INTO gas_stations(id,name,brand,lat,lng) 
VALUES (8,'Shell Station','Shell','32.83776989676744','-96.96001052856445');

INSERT INTO gas_stations(id,name,brand,lat,lng) 
VALUES (9,'Royal Lane','Shell','32.94703000944158','-97.02249526977539');

INSERT INTO gas_stations(id,name,brand,lat,lng) 
VALUES (10,'Airport Fwy','Conoco','32.83575063295597','-97.02369689941406');

-- Convert latitude and longitude to sdo_geometry.
update gas_stations set geom = 
  MDSYS.SDO_GEOMETRY(2001
                    ,4326
                    ,MDSYS.SDO_POINT_TYPE (lng, lat,NULL)
                    ,NULL
                    ,NULL);

-- Create spatial metadata and index.
-- This is neccessary for performing spatial operations on the data.
begin
    apex_spatial.insert_geom_metadata (
           p_table_name        => 'GAS_STATIONS'
          ,p_column_name       => 'GEOM'
          ,p_diminfo           => SDO_DIM_ARRAY (
                                    SDO_DIM_ELEMENT('X', -180, 180, 1),
                                    SDO_DIM_ELEMENT('Y',  -90,  90, 1) 
                                 )
          ,p_srid              => 4326
          ,p_create_index_name => 'GAS_STATIONS_GEOM_IDX'
    );
end;
-- End of Sample Objects and Data --
