<%@ Page Title="Actualizar estado de usuario" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActualizarUsuario.aspx.cs" Inherits="BancoPrueba.ActualizarUsuario" %>

<asp:Content ID="MainContentBlock" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Actualizar estado de usuario</h1>
    <div class="mb-3">
        <asp:Label ID="lblUsuarioID" runat="server" AssociatedControlID="txtUsuarioID" Text="Usuario ID" />
        <asp:TextBox ID="txtUsuarioID" runat="server" CssClass="form-control" TextMode="Number" />
    </div>
    <div class="mb-3">
        <asp:CheckBox ID="chkEstado" runat="server" Text="Usuario activo" Checked="true" />
    </div>
    <asp:Button ID="btnActualizar" runat="server" Text="Actualizar estado" CssClass="btn btn-primary" OnClick="btnActualizar_Click" />
    <asp:Label ID="lblMensaje" runat="server" CssClass="status-message" />
</asp:Content>
