Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Text
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MODTOOLS
    Const CGParametro As Integer = 1
    Const CGobligatorio As Integer = 2
    Const CGError As Integer = 3
    Const CGCaracter As Integer = 4
    Const CGDato As Integer = 5
    Const CGAccion As Integer = 6

    Function FMCodDescripcion(ByRef Forma As Object, ByRef Index As Integer, ByRef lbl As Integer, ByRef trn As String, ByRef sp As String, ByRef elemento As Integer) As Boolean
        Dim X As Integer = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, trn)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V")
        PMPasoValores(sqlconn, FMPropiedad(Forma.txtCampo(Index), CGParametro), 0, SQLINT2, Forma.txtCampo(Index).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", sp, False, "") Then
            Dim VTArreglo(5) As String
            X = FMMapeaArreglo(sqlconn, VTArreglo)
            Forma.lblDescripcion(lbl).Text = VTArreglo(elemento)
            PMChequea(sqlconn)
            Return True
        Else
            Forma.txtCampo(Index).Text = ""
            Forma.lblDescripcion(lbl).Text = ""
            Return False
        End If
    End Function

    Function FMPropiedad(ByRef objeto As Object, ByRef Index As Integer) As String
        Dim VTDatos As String = String.Empty
        Dim Caracter As String = String.Empty
        Dim VTDato As New StringBuilder
        Dim Token As Integer = 0
        Dim VTPosicion As Integer = 0
        VTPosicion = 1
        Token = 1
        Do While (VTPosicion <= Strings.Len(objeto.Tag) And Index > 1)
            Caracter = Strings.Mid(objeto.Tag, VTPosicion, 1)
            If Caracter = ";" Then
                Token += 1
                If Token = Index Then
                    VTPosicion += 1
                    Exit Do
                End If
            End If
            VTPosicion += 1
        Loop
        VTDatos = ""
        Do While (Strings.Mid(objeto.Tag, VTPosicion, 1) <> ";") And (VTPosicion <= Strings.Len(objeto.Tag))
            VTDato.Append(Strings.Mid(objeto.Tag, VTPosicion, 1))
            VTPosicion += 1
        Loop
        Return VTDato.ToString()
    End Function

    Function FMValidarCaracter(ByRef Forma As Object, ByRef Index As Integer, ByRef Keypress As Integer) As Integer
        Dim tipo As String = ""
        tipo = FMPropiedad(Forma.txtCampo(Index), CGCaracter)
        If tipo <> "" Then
            Return FMValidaTipoDato(tipo, Keypress)
        Else
            Return Keypress
        End If
    End Function

    Function FMValidarDato(ByRef Forma As Object, ByRef Index As Integer) As Boolean
        Dim tipo As String = ""
        tipo = FMPropiedad(Forma.txtCampo(Index), CGDato)
        If tipo <> "" And Forma.txtCampo(Index).Text <> "" Then
            Return FMTipoDato(Forma.txtCampo(Index), tipo)
        Else
            Return True
        End If
    End Function

    Sub PMAjustarVentanaBus(ByRef Forma As Object)
        Forma.Left = Compatibility.VB6.TwipsToPixelsX(165)
        Forma.Top = Compatibility.VB6.TwipsToPixelsY(1425)
    End Sub

    Sub PMEliminarMatriz(ByRef Forma As Object, ByRef asiento As String) 'FComprobanteClass
        Dim i As Integer = 0
        i = 1
        Forma.grdMatrizItems.Col = 0
        Do While i <= Forma.grdMatrizItems.Rows - 1
            Forma.grdMatrizItems.Row = i
            If Forma.grdMatrizItems.CtlText = asiento.TrimStart() Then
                Forma.grdMatrizItems.RemoveItem(CShort(i))
                i -= 1
            End If
            i += 1
        Loop
    End Sub

    Sub PMIngresarMatriz(ByRef Forma As Object, ByRef asiento As String, ByRef opcion As String, ByRef debcred As String, ByRef item As String, ByRef Valor As String)
        Dim i As Integer = 0
        i = 1
        Forma.grdMatrizItems.Col = 0
        Do While i <= Forma.grdMatrizItems.Rows - 1
            Forma.grdMatrizItems.Row = i
            If Conversion.Val(Forma.grdMatrizItems.Text) > Conversion.Val(asiento) Then
                Exit Do
            End If
            i += 1
        Loop
        Forma.grdMatrizItems.AddItem(asiento.TrimStart() & Strings.Chr(9).ToString() & opcion & Strings.Chr(9).ToString() & debcred & Strings.Chr(9).ToString() & item & Strings.Chr(9).ToString() & Valor & Strings.Chr(9).ToString() & "R", i)
    End Sub

    Sub PMLimpiartxtlbl(ByRef Forma As Object, ByRef txt As Integer, ByRef lbl As Integer, ByRef focus As Integer)
        For i As Integer = 0 To txt
            Forma.txtCampo(i).Text = ""
        Next i
        For i As Integer = 0 To lbl
            Forma.lblDescripcion(i).Text = ""
        Next i
        Forma.txtCampo(focus).Focus()
    End Sub

    Sub PMMensajeAccion(ByRef Forma As Object, ByRef Index As Integer)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMPropiedad(Forma.txtCampo(Index), CGAccion))
        Forma.txtCampo(Index).SelectionStart = 0
        Forma.txtCampo(Index).SelectionLength = Strings.Len(Forma.txtCampo(Index).Text)
    End Sub
End Module


