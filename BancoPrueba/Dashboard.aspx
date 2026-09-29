
<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="BancoPrueba.Dashboard" %>

<asp:Content ID="MainContentBlock" ContentPlaceHolderID="MainContent" runat="server">
    <section class="welcome-panel">
        <p class="eyebrow">Panel principal</p>
        <h1>Bienvenido a BancoPrueba</h1>
        <p class="lead">Administra usuarios, cuentas y consultas desde un unico lugar.</p>
    </section>

    <section class="dashboard-section" aria-labelledby="quickLinksTitle">
        <h2 id="quickLinksTitle">Accesos rapidos</h2>
        <div class="dashboard-grid">
            <asp:HyperLink ID="lnkCrearUsuario" runat="server" NavigateUrl="~/Pages/CrearUsuario.aspx" CssClass="dashboard-card">
                <span class="card-number">01</span>
                <span class="card-title">Crear usuario y cuenta</span>
                <span class="card-description">Registrar un usuario y su cuenta bancaria.</span>
            </asp:HyperLink>
            <asp:HyperLink ID="lnkActualizarUsuario" runat="server" NavigateUrl="~/Pages/ActualizarUsuario.aspx" CssClass="dashboard-card">
                <span class="card-number">02</span>
                <span class="card-title">Actualizar estado de usuario</span>
                <span class="card-description">Acceder a la gestion del estado de usuario.</span>
            </asp:HyperLink>
            <asp:HyperLink ID="lnkEstadoCuenta" runat="server" NavigateUrl="~/Pages/EstadoCuenta.aspx" CssClass="dashboard-card">
                <span class="card-number">03</span>
                <span class="card-title">Estado de cuenta</span>
                <span class="card-description">Consultar saldos y movimientos de una cuenta.</span>
            </asp:HyperLink>
            <asp:HyperLink ID="lnkTopUsuarios" runat="server" NavigateUrl="~/Pages/TopUsuarios.aspx" CssClass="dashboard-card">
                <span class="card-number">04</span>
                <span class="card-title">Reporte top usuarios</span>
                <span class="card-description">Abrir el reporte de usuarios destacados.</span>
            </asp:HyperLink>
        </div>
    </section>
</asp:Content>
