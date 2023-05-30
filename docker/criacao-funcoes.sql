CREATE FUNCTION dbo.FormatDateDMA(@date DATETIME)
    RETURNS VARCHAR(8)
AS
BEGIN
    IF (@date IS NULL)
        RETURN ''
    ELSE
        RETURN REPLACE(CONVERT(VARCHAR(10), CONVERT(DATE, @date, 112), 103), '/', '')

    RETURN ''
END
GO

CREATE Function [dbo].[Aud_Mask](
@Value Decimal(27,10),
@Separator nVarChar(1) = ',',
@Decimal as Integer = 2,
@StrSpace nVarChar(1) = '',
@Lenght as Integer = 19)
    RETURNS VarChar(30)
As
Begin
    Declare
        @WReturn VarChar(30)
        ,@WPos as integer
    Set @WReturn = REPLACE(@Value, '.', @Separator)
    Set @WPos = LEN(@WReturn)
    If @Value = 0
        Set @WReturn = '0';
    Else
        If CHARINDEX(@Separator, @WReturn) > 0
            While @WPos > 1
                Begin
                    If SUBSTRING(@WReturn, @WPos, 1) <> '0'
                        BREAK;
                    Set @WPos = @WPos - 1
                End
    If SUBSTRING(@WReturn, @WPos, 1) = @Separator
        Set @WReturn = LEFT(@WReturn, @WPos - 1)
    Else
        Set @WReturn = LEFT(@WReturn, @WPos)

    RETURN (@WReturn)
END
GO