CREATE PROCEDURE sp_CrearUsuarioYCuenta
(
    @NombreCompleto VARCHAR(100),
    @Email VARCHAR(150)
)
AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        DECLARE @UsuarioID INT;


        INSERT INTO Usuarios
        (
            NombreCompleto,
            Email
        )
        VALUES
        (
            @NombreCompleto,
            @Email
        );


        SET @UsuarioID = SCOPE_IDENTITY();


        INSERT INTO Cuentas
        (
            UsuarioID,
            SaldoActual
        )
        VALUES
        (
            @UsuarioID,
            0.00
        );


        COMMIT TRANSACTION;


        SELECT 
            @UsuarioID AS UsuarioCreado,
            'Usuario y cuenta creados correctamente' AS Mensaje;


    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END


        DECLARE @MensajeError VARCHAR(4000);

        SET @MensajeError = ERROR_MESSAGE();


        RAISERROR
        (
            @MensajeError,
            16,
            1
        );

    END CATCH

END;
GO


CREATE PROCEDURE sp_ActualizarEstadoUsuario
(
    @UsuarioID INT,
    @Estado BIT
)
AS
BEGIN

    SET NOCOUNT ON;


    BEGIN TRY

        DECLARE @Saldo DECIMAL(18,2);


        IF @Estado = 0
        BEGIN

            SELECT 
                @Saldo = SaldoActual
            FROM Cuentas
            WHERE UsuarioID = @UsuarioID;


            IF @Saldo > 0
            BEGIN

                RAISERROR
                (
                    'No se puede desactivar el usuario porque posee fondos disponibles.',
                    16,
                    1
                );

                RETURN;

            END

        END


        UPDATE Usuarios
        SET Estado = @Estado
        WHERE UsuarioID = @UsuarioID;


        SELECT 
            'Estado actualizado correctamente' AS Mensaje;


    END TRY

    BEGIN CATCH

        DECLARE @Error VARCHAR(4000);

        SET @Error = ERROR_MESSAGE();


        RAISERROR
        (
            @Error,
            16,
            1
        );

    END CATCH

END;
GO


CREATE PROCEDURE sp_GenerarEstadoCuenta
(
    @CuentaID INT,
    @FechaInicio DATETIME,
    @FechaFin DATETIME
)
AS
BEGIN

    SET NOCOUNT ON;


    SELECT
        U.NombreCompleto,
        C.SaldoActual,

        ISNULL(
            SUM(
                CASE 
                    WHEN H.TipoMovimiento = 'C'
                    THEN H.Monto
                    ELSE 0
                END
            ),
        0) AS TotalCreditos,


        ISNULL(
            SUM(
                CASE 
                    WHEN H.TipoMovimiento = 'D'
                    THEN H.Monto
                    ELSE 0
                END
            ),
        0) AS TotalDebitos


    FROM Cuentas C

    INNER JOIN Usuarios U
        ON C.UsuarioID = U.UsuarioID

    LEFT JOIN HistorialTransacciones H
        ON C.CuentaID = H.CuentaID
        AND H.FechaTransaccion BETWEEN @FechaInicio AND @FechaFin


    WHERE C.CuentaID = @CuentaID


    GROUP BY
        U.NombreCompleto,
        C.SaldoActual;



    SELECT
        FechaTransaccion,
        TipoMovimiento,
        Monto,
        ReferenciaExterna

    FROM HistorialTransacciones

    WHERE CuentaID = @CuentaID
    AND FechaTransaccion BETWEEN @FechaInicio AND @FechaFin

    ORDER BY
        FechaTransaccion DESC;


END;
GO


CREATE PROCEDURE sp_ReporteTopUsuarios
(
    @DiasAtras INT
)
AS
BEGIN

    SET NOCOUNT ON;


    SELECT TOP 5

        U.UsuarioID,

        U.NombreCompleto,

        U.Email,

        COUNT(H.TransaccionID) AS CantidadTransacciones,

        SUM(H.Monto) AS VolumenTotal


    FROM Usuarios U


    INNER JOIN Cuentas C
        ON U.UsuarioID = C.UsuarioID


    INNER JOIN HistorialTransacciones H
        ON C.CuentaID = H.CuentaID


    WHERE 
        U.Estado = 1

        AND H.FechaTransaccion >= DATEADD(DAY, -@DiasAtras, GETDATE())


    GROUP BY

        U.UsuarioID,

        U.NombreCompleto,

        U.Email


    ORDER BY

        VolumenTotal DESC;


END;
GO