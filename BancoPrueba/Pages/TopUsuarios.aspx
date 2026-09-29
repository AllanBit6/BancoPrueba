<%@ Page Title="Reporte top usuarios" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TopUsuarios.aspx.cs" Inherits="BancoPrueba.TopUsuarios" %>

<asp:Content ID="MainContentBlock" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Reporte top usuarios</h1>
    <div class="mb-3">
        <asp:Label ID="lblDiasAtras" runat="server" AssociatedControlID="txtDiasAtras" Text="Dias atras" />
        <asp:TextBox ID="txtDiasAtras" runat="server" CssClass="form-control" TextMode="Number" />
    </div>
    <asp:Button ID="btnConsultar" runat="server" Text="Consultar" CssClass="btn btn-primary" OnClick="btnConsultar_Click" />
    <asp:Label ID="lblMensaje" runat="server" CssClass="status-message" />
    <asp:GridView ID="gvTopUsuarios" runat="server" AutoGenerateColumns="true" CssClass="table table-striped" EmptyDataText="No hay usuarios con transacciones en el periodo indicado." GridLines="None" />
</asp:Content>
