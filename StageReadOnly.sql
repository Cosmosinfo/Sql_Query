-- 스테이지 2개등록 검색
SELECT * FROM tb_fulldive_stage
WHERE 1=1
AND (STAGE_ID = '8e30bc81-fe07-4c32-8fda-be63b50126b7' OR stage_combine_id = '8e30bc81-fe07-4c32-8fda-be63b50126b7')
;

-- 진행중인 스테이지 목록 (4개)
SELECT * FROM (
       SELECT
           STAGE_ID,
           CREATE_TIMESTAMP,
           USER_ID,
           STAGE_TITLE,
           STAGE_IMAGE,
           STAGE_LOCATION,
           STAGE_TIMESTAMP,
           STAGE_ARTIST_ID,
           STAGE_DESCRIPTION,
           STAGE_THUMBNAIL_IMAGE,
           STAGE_TICKET_PRICE,
           STAGE_CURRENT,
           STAGE_STREAM_KEY,
           STAGE_COMBINE_ID,
           CASE WHEN STAGE_COMBINE_ID IS NULL THEN '1' ELSE '2' END AS STAGE_SEQUENCE
    FROM TB_FULLDIVE_STAGE
    WHERE 1=1
    ) TFSTG
WHERE 1=1
    AND STAGE_SEQUENCE = '1'
    AND STAGE_CURRENT = 'S'
ORDER BY STAGE_TIMESTAMP ASC
LIMIT 4
