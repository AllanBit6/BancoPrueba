USE BancoPrueba;
GO


DECLARE @i INT = 1;

WHILE @i <= 100
BEGIN

    INSERT INTO Usuarios
    (
        NombreCompleto,
        Email
    )
    VALUES
    (
        CONCAT('Usuario Prueba ', @i),
        CONCAT('usuario', @i, '@correo.com')
    );


    SET @i = @i + 1;

END;
GO


DECLARE @i INT = 1;

WHILE @i <= 100
BEGIN

    INSERT INTO Cuentas
    (
        UsuarioID,
        SaldoActual
    )
    VALUES
    (
        @i,
        (@i * 100)
    );


    SET @i = @i + 1;

END;
GO


DECLARE @i INT = 1;

WHILE @i <= 100
BEGIN

    INSERT INTO HistorialTransacciones
    (
        CuentaID,
        TipoMovimiento,
        Monto,
        ReferenciaExterna
    )
    VALUES
    (
        @i,

        CASE 
            WHEN @i % 2 = 0 
            THEN 'C'
            ELSE 'D'
        END,

        (@i * 50),

        CONCAT('MOV-', @i)
    );


    SET @i = @i + 1;

END;
GO


DECLARE @i INT = 1;

WHILE @i <= 200
BEGIN

    INSERT INTO HistorialTransacciones
    (
        CuentaID,
        TipoMovimiento,
        Monto,
        ReferenciaExterna
    )
    VALUES
    (
        ((@i % 100) + 1),

        CASE 
            WHEN @i % 2 = 0 
            THEN 'C'
            ELSE 'D'
        END,

        (@i * 25),

        CONCAT('MOV-EXTRA-', @i)
    );


    SET @i = @i + 1;

END;
GO