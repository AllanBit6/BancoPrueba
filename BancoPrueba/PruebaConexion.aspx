<%@ Page Title="Prueba de conexión" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PruebaConexion.aspx.cs" Inherits="BancoPrueba.PruebaConexion" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Button 
        ID="btnProbar"
        runat="server"
        Text="Probar conexión"
        OnClick="btnProbar_Click" />

    <br /><br />

    <asp:Label
        ID="lblMensaje"
        runat="server">
    </asp:Label>
</asp:Content>
