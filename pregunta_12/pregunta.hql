DROP TABLE IF EXISTS t0;
DROP TABLE IF EXISTS datos;
CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>, 
    c3 MAP<STRING, INT>
    )
    ROW FORMAT DELIMITED 
        FIELDS TERMINATED BY '\t'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY '#'
        LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;
/*
    >>> Escriba su respuesta a partir de este punto <<<
*/

INSERT OVERWRITE LOCAL DIRECTORY './output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT 
    letter, 
    letters,
    count(letters) AS conteo
FROM t0
LATERAL VIEW
    EXPLODE(c2) t0 AS letter
LATERAL VIEW
    EXPLODE(c3) t0 AS letters, numbers
GROUP BY letter, letters;
