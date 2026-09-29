<%@ Page Title="Crear usuario" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrearUsuario.aspx.cs" Inherits="BancoPrueba.CrearUsuario" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Crear usuario y cuenta</h2>

    <div class="mb-3">
        <asp:Label ID="lblNombreCompleto" runat="server" AssociatedControlID="txtNombreCompleto" Text="Nombre completo" />
        <asp:TextBox ID="txtNombreCompleto" runat="server" CssClass="form-control" MaxLength="100" />
    </div>

    <div class="mb-3">
        <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email" />
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" MaxLength="150" TextMode="Email" />
    </div>

    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
    <br /><br />
    <asp:Label ID="lblMensaje" runat="server" />
</asp:Content>
