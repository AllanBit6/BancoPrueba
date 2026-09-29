<%@ Page Title="Estado de cuenta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EstadoCuenta.aspx.cs" Inherits="BancoPrueba.EstadoCuenta" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Estado de cuenta</h2>

    <div class="mb-3">
        <asp:Label ID="lblCuentaIDEntrada" runat="server" AssociatedControlID="txtCuentaID" Text="Cuenta ID" />
        <asp:TextBox ID="txtCuentaID" runat="server" CssClass="form-control" TextMode="Number" />
    </div>

    <div class="mb-3">
        <asp:Label ID="lblFechaInicioEntrada" runat="server" AssociatedControlID="txtFechaInicio" Text="Fecha inicial" />
        <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="form-control" TextMode="Date" />
    </div>

    <div class="mb-3">
        <asp:Label ID="lblFechaFinEntrada" runat="server" AssociatedControlID="txtFechaFin" Text="Fecha final" />
        <asp:TextBox ID="txtFechaFin" runat="server" CssClass="form-control" TextMode="Date" />
    </div>

    <asp:Button ID="btnConsultar" runat="server" Text="Consultar" CssClass="btn btn-primary" OnClick="btnConsultar_Click" />
    <br /><br />
    <asp:Label ID="lblMensaje" runat="server" />

    <section class="mt-4">
        <h3>Resumen</h3>
        <p>Nombre: <asp:Label ID="lblNombreCompleto" runat="server" /></p>
        <p>Saldo actual: <asp:Label ID="lblSaldoActual" runat="server" /></p>
        <p>Total créditos: <asp:Label ID="lblTotalCreditos" runat="server" /></p>
        <p>Total débitos: <asp:Label ID="lblTotalDebitos" runat="server" /></p>
    </section>

    <section class="mt-4">
        <h3>Movimientos</h3>
        <asp:GridView ID="gvDetalle" runat="server" AutoGenerateColumns="true" CssClass="table table-striped" EmptyDataText="No hay movimientos para los criterios indicados." GridLines="None" />
    </section>
</asp:Content>
