
DECLARE @ReservationNo AS VARCHAR(50) = '426410';
DECLARE @Amount AS DECIMAL(15,3) = 18924.800;
DECLARE @Date AS VARCHAR(50) = '2025/11/19';
DECLARE @DPSTxn AS VARCHAR(50) = '';

SELECT 
    CASE
        WHEN DPS_ReservationNo = @ReservationNo
            THEN 'Matches Reservation No'
        WHEN CAST(DPS_Amount AS DECIMAL(15,3)) = @Amount
            THEN 'Matches Amount'
        WHEN DPS_ReservationNo = @ReservationNo AND CAST(DPS_Amount AS DECIMAL(15,3)) = @Amount
            THEN 'Matches ResNo and Amount'
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