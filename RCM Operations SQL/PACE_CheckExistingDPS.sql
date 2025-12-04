
DECLARE @ReservationNo AS VARCHAR(50) = '428650';
DECLARE @Amount AS DECIMAL(15,3) = 6012.000;
DECLARE @Date AS VARCHAR(50) = '2025/12/03';
DECLARE @DPSTxn AS VARCHAR(50) = '';

SELECT 
    CASE
        WHEN DPS_ReservationNo = @ReservationNo AND CAST(DPS_Amount AS DECIMAL(15,3)) = @Amount
            THEN 'Matches ResNo and Amount'
        WHEN DPS_ReservationNo = @ReservationNo
            THEN 'Matches Reservation No'
        WHEN CAST(DPS_Amount AS DECIMAL(15,3)) = @Amount
            THEN 'Matches Amount'
        ELSE 'No Match'
    END AS MatchReason,
	DPS_ID,
	DPS_MerchantReference,
	DPS_CardHolderName,
	DPS_Amount,
	DPS_CardNumber,
	DPS_DateExpiry,
	DPS_DpsTxnRef,
	DPS_ReservationNo,
	DPS_ReservationBufferNo,
	DPS_DateCreated,
	Status
FROM
	DPSPayment

WHERE	
	(
		DPS_ReservationNo = @ReservationNo
		OR DPS_MerchantReference = @ReservationNo
		OR CAST(DPS_Amount AS DECIMAL(15,3)) = @Amount
	)
	AND DPS_DateCreated >= @Date
ORDER BY DPS_ReservationNo, DPS_CardHolderName, DPS_AMOUNT, DPS_ID DESC;

SELECT
	
    CASE
        WHEN ReservationNo = @ReservationNo AND CAST(Paid AS DECIMAL(15,3)) = @Amount
            THEN 'Matches ResNo and Amount'
        WHEN ReservationNo = @ReservationNo
            THEN 'Matches Reservation No'
        WHEN CAST(Paid AS DECIMAL(15,3)) = @Amount
            THEN 'Matches Amount'
        ELSE 'No Match'
    END AS MatchReason
	,ReservationNo
	,Paid
	,PaymentTokenID
	,PaymentDate
	,OtherExtraDesc
FROM
	ReservationPayment
WHERE
	ReservationNo = @ReservationNo
;