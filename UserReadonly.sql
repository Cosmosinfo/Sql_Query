-- 유저별 코멧정보
SELECT TFU.USER_ID,
       TFU.USER_EMAIL,
       TFU.USER_CHK_EMAIL,
       TFU.USER_PASSWORD,
       TFU.USER_NICKNAME,
       TFU.USER_BIRTH,
       TFU.USER_NAME,
       TFU.USER_ACCESS,
       TFU.USER_PHONE,
       TFU.USER_PROFILE_IMAGE,
       TFU.USER_GENDER,
       TFU.USER_NATION,
       TFU.USER_ADDRESS,
       COALESCE((SELECT(SUM
           (CASE
                WHEN TFPH.PAYMENT_DIVISION = 'S' THEN -(TFPH.PAYMENT_PRICE)
                WHEN TFPH.PAYMENT_DIVISION = 'P' THEN TFPH.PAYMENT_PRICE
                   END)
                           )
                 FROM TB_FULLDIVE_PAYMENT_HISTORY TFPH
                 WHERE TFPH.PAYMENT_RECEPTION_ID = TFU.USER_ID), 0) AS USER_COMET_INFO,
       COALESCE((SELECT SUM(CASE
                                WHEN TICKET_USE_STATUS = 'T' THEN 1
                                WHEN TICKET_USE_STATUS = 'F' THEN -1
           END) AS USER_TICKET_COUNT
                 FROM TB_FULLDIVE_TICKET_HISTORY
                 WHERE 1 = 1
                   AND USER_ID = TFU.USER_ID
                ), 0)                                               AS USER_TICKET_COUNT,
       TO_CHAR(CREATE_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')           AS CREATE_TIMESTAMP,
       COALESCE((SELECT
            SUM(CASE WHEN TICKET_USE_STATUS = 'T' THEN 1
                 WHEN TICKET_USE_STATUS = 'F' THEN -1
            END) AS USER_TICKET_COUNT
            FROM
                 TB_FULLDIVE_TICKET_HISTORY TH,
                 TB_FULLDIVE_TICKET T
        WHERE 1=1
        AND TH.TICKET_HISTORY_ID = T.TICKET_ID
        AND T.TICKET_DIVISION = 'E'
        AND USER_ID = TFU.USER_ID
        ),0) AS USER_TICKET_E_COUNT,
       COALESCE((SELECT
            SUM(CASE WHEN TICKET_USE_STATUS = 'T' THEN 1
                 WHEN TICKET_USE_STATUS = 'F' THEN -1
            END) AS USER_TICKET_COUNT
            FROM
                 TB_FULLDIVE_TICKET_HISTORY TH,
                 TB_FULLDIVE_TICKET T
        WHERE 1=1
        AND TH.TICKET_HISTORY_ID = T.TICKET_ID
        AND T.TICKET_DIVISION = 'N'
        AND USER_ID = TFU.USER_ID
        ),0) AS USER_TICKET_N_COUNT,
       COALESCE((SELECT
            SUM(CASE WHEN TICKET_USE_STATUS = 'T' THEN 1
                 WHEN TICKET_USE_STATUS = 'F' THEN -1
            END) AS USER_TICKET_COUNT
            FROM
                 TB_FULLDIVE_TICKET_HISTORY TH,
                 TB_FULLDIVE_TICKET T
        WHERE 1=1
        AND TH.TICKET_HISTORY_ID = T.TICKET_ID
        AND T.TICKET_DIVISION = 'P'
        AND USER_ID = TFU.USER_ID
        ),0) AS USER_TICKET_P_COUNT
FROM TB_FULLDIVE_USER TFU
WHERE 1 = 1
;