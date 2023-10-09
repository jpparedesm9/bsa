VERSION 5.00
Begin VB.Form FCatalogo 
   Appearance      =   0  'Flat
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Registros Seleccionados"
   ClientHeight    =   3225
   ClientLeft      =   4275
   ClientTop       =   1350
   ClientWidth     =   5295
   ControlBox      =   0   'False
   FillColor       =   &H00FFFFFF&
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00FFFFFF&
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3225
   ScaleWidth      =   5295
   Begin VB.CommandButton cmdSiguientes 
      Appearance      =   0  'Flat
      Caption         =   "&Siguientes"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   15
      TabIndex        =   1
      Top             =   2865
      Width           =   5265
   End
   Begin VB.ListBox lstCatalogo 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   2670
      Left            =   15
      TabIndex        =   0
      Top             =   15
      Width           =   5265
   End
End
Attribute VB_Name = "FCatalogo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*********************************************************
'   Archivo:                FCATALOG.FRM - FCatalogo
'   Producto:               Terminal Administrativa
'   Fecha de Documentación: 6-Junio-1994
'*********************************************************
'                       IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios pro-
' piedad de MACOSA, representantes exclusivos para el Ecua-
' dor de la NCR CORPORATION.  Su uso no autorizado queda
' expresamente prohibido así como cualquier alteración o
' agregado hecho por alguno de sus usuarios sin el debido
' consentimiento por escrito de la Presidencia Ejecutiva
' de MACOSA o su representante
'*********************************************************
' DESCRIPCION:  Esta forma despliega todas las ayudas
'               via F5 de la Terminal Administrativa
'*********************************************************
' DECLARACIONES GLOBALES:
' Ninguna
'*********************************************************
'

Private Sub cmdSiguientes_Click()
'*********************************************************
'Objetivo:  Permite obtener los siguientes registros
'           de la lista de ayuda seleccionada
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    Dim VTUb1%

    lstCatalogo.ListIndex = lstCatalogo.ListCount - 1
    VTUb1% = InStr(1, lstCatalogo.Text, Chr$(9))
    Select Case VGOperacion$
    ' Ayuda de Filiales
    Case "sp_filial"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, Mid$(FCatalogo.lstCatalogo.Text, 1, VTUb1% - 1)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_filial", True, "Ok... Consulta de la filiales") Then
             PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, True
             PMChequea sqlconn&
        End If
    ' Ayuda de Oficinas
    Case "sp_oficina"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, Mid$(FCatalogo.lstCatalogo.Text, 1, VTUb1% - 1)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_oficina", True, "Ok... Consulta de oficinas") Then
             PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, True
             PMChequea sqlconn&
        End If
    ' Ayuda de Monedas
    Case "sp_moneda"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, Mid$(FCatalogo.lstCatalogo.Text, 1, VTUb1% - 1)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_moneda", True, "Ok... Consulta de monedas") Then
             PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, True
             PMChequea sqlconn&
        End If
    ' Ayuda de Tipos de chequeras
    Case "sp_tipo_chequera"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "35"
         PMPasoValores sqlconn&, "@i_tchq", 0, SQLVARCHAR, Mid$(FCatalogo.lstCatalogo.Text, 1, VTUb1% - 1)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tipo_chequera", True, " Ok... Consulta de chequeras") Then
             PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, True
             PMChequea sqlconn&
        End If
    End Select
End Sub

Private Sub Form_Activate()
'*********************************************************
'Objetivo:  Permite activar o desactivar el boton de
'           siguientes de la lista de ayuda seleccionada
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    
    If lstCatalogo.ListCount < 20 Then
        cmdSiguientes.Enabled = False
    Else
        cmdSiguientes.Enabled = True
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
Dim VTUb1%
Dim VTUb2%
    If KeyAscii% = 27 Then
        VGACatalogo.Codigo$ = ""
        VGACatalogo.Descripcion$ = ""
        Unload FCatalogo
    Else
        If KeyAscii% = 13 Then
            If FCatalogo.lstCatalogo.ListCount <> 0 Then
                VTUb1% = InStr(1, lstCatalogo.Text, Chr$(9))
                VGACatalogo.Codigo$ = Mid$(FCatalogo.lstCatalogo.Text, 1, VTUb1% - 1)
                VTUb2% = InStr(VTUb1% + 1, FCatalogo.lstCatalogo.Text, Chr$(9))
                If VTUb2% <> 0 Then
                    VGACatalogo.Descripcion$ = Mid$(FCatalogo.lstCatalogo.Text, VTUb1% + 1, VTUb2% - VTUb1% - 1)
                Else
                    VGACatalogo.Descripcion$ = Mid$(FCatalogo.lstCatalogo.Text, VTUb1% + 1, Len(FCatalogo.lstCatalogo.Text) - VTUb1% + 1)
                End If
            Else
                VGACatalogo.Codigo$ = ""
                VGACatalogo.Descripcion$ = ""
            End If
            Unload FCatalogo
        End If
    End If
End Sub

Private Sub lstCatalogo_DblClick()
'*********************************************************
'Objetivo:  Permite seleccionar un dato de la lista de
'           ayuda que se encuentra activa
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    Dim VTUb1%
    Dim VTUb2%
    If FCatalogo.lstCatalogo.ListCount <> 0 Then
        VTUb1% = InStr(1, lstCatalogo.Text, Chr$(9))
        VGACatalogo.Codigo$ = Mid$(FCatalogo.lstCatalogo.Text, 1, VTUb1% - 1)
        VTUb2% = InStr(VTUb1% + 1, FCatalogo.lstCatalogo.Text, Chr$(9))
        If VTUb2% <> 0 Then
            VGACatalogo.Descripcion$ = Mid$(FCatalogo.lstCatalogo.Text, VTUb1% + 1, VTUb2% - VTUb1% - 1)
        Else
            VGACatalogo.Descripcion$ = Mid$(FCatalogo.lstCatalogo.Text, VTUb1% + 1, Len(FCatalogo.lstCatalogo.Text) - VTUb1% + 1)
        End If
    Else
        VGACatalogo.Codigo$ = ""
        VGACatalogo.Descripcion$ = ""
    End If
    Unload FCatalogo
End Sub



