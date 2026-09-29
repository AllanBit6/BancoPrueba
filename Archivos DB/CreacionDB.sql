CREATE DATABASE BancoPrueba;
GO

USE BancoPrueba;
GO


CREATE TABLE Usuarios
(
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    NombreCompleto VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Estado BIT NOT NULL DEFAULT 1,
    FechaAlta DATETIME NOT NULL DEFAULT GETDATE()
);
GO


CREATE TABLE Cuentas
(
    CuentaID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    SaldoActual DECIMAL(18,2) NOT NULL DEFAULT 0.00,
    Estado BIT NOT NULL DEFAULT 1,
    FechaAlta DATETIME NOT NULL DEFAULT GETDATE(),
    UltimaActualizacion DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Cuentas_Usuarios
    FOREIGN KEY (UsuarioID)
    REFERENCES Usuarios(UsuarioID)
);
GO


CREATE TABLE HistorialTransacciones
(
    TransaccionID BIGINT IDENTITY(1,1) PRIMARY KEY,
    CuentaID INT NOT NULL,
    TipoMovimiento CHAR(1) NOT NULL,
    Monto DECIMAL(18,2) NOT NULL,
    FechaTransaccion DATETIME NOT NULL DEFAULT GETDATE(),
    ReferenciaExterna VARCHAR(50) NULL,
    Estado BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_Historial_Cuentas
    FOREIGN KEY (CuentaID)
    REFERENCES Cuentas(CuentaID),

    CONSTRAINT CK_TipoMovimiento
    CHECK (TipoMovimiento IN ('D','C')),

    CONSTRAINT CK_Monto
    CHECK (Monto > 0)
);
GO