-- AlterTable
ALTER TABLE "SoilSample"
    ALTER COLUMN "depth" DROP NOT NULL,
    ALTER COLUMN "location" DROP NOT NULL,
    ALTER COLUMN "repetition" DROP NOT NULL,
    ALTER COLUMN "x_coord" DROP NOT NULL,
    ALTER COLUMN "y_coord" DROP NOT NULL;

-- Enable PostGIS extension first
CREATE EXTENSION IF NOT EXISTS postgis;

-- Then alter Plot table using PostGIS
ALTER TABLE "Plot"
ALTER COLUMN plot_border TYPE geometry(Geometry, 4326)
USING CASE 
     WHEN plot_border IS NOT NULL 
     THEN ST_SetSRID(ST_GeomFromGeoJSON(plot_border::text), 4326)
     ELSE NULL
END;
