VERSION 5.00
Begin VB.Form FCatalogo 
   Appearance      =   0  'Flat
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Registros Seleccionados"
   ClientHeight    =   3240
   ClientLeft      =   3810
   ClientTop       =   1650
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
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3240
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
      Height          =   2835
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
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VTUb1 As Integer
Dim VTUb2

'*********************************************************
'   ARCHIVO:                FCATALOG.FRM - FCatalogo
'   NOMBRE LOGICO:          FCatalogo
'   PRODUCTO:               Terminal Administrativa
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
'                       PROPOSITO
' DESCRIPCION:  Esta forma despliega todas las ayudas
'               via F5 de la Terminal Administrativa
'*********************************************************
'                      MODIFICACIONES
'     FECHA            AUTOR             RAZON
'     6-Junio-1994                       Emision Inicial
'*********************************************************

Private Sub cmdSiguientes_Click()
'*********************************************************
'PROPOSITO: Permite obtener los siguientes registros
'           de la lista de ayuda seleccionada
'INPUT:     ninguna
'OUTPUT:    ninguna
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    Dim VTUb2 As Integer
    

    lstCatalogo.ListIndex = lstCatalogo.ListCount - 1
    VTUb1 = InStr(1, lstCatalogo.Text, Chr$(9))
    Select Case VGOperacion$
    ' Ayuda de Filiales
    Case "sp_filial"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_filial", True, "Ok... Consulta de la filiales") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If
    ' Ayuda de Oficinas
    Case "sp_oficina"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1574"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_oficina", True, "Ok... Consulta de agencias") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If
    ' Ayuda de Monedas
    Case "sp_moneda"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_moneda", True, "Ok... Consulta de monedas") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If

    ' Ayuda de Agencias del Banco
    Case "sp_agencia"
         PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_sig", 0, SQLINT2, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Ok... Consulta de Agencias") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If

    ' Ayuda de Tipos de chequeras
    Case "sp_tipo_chequera"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "35"
         PMPasoValores sqlconn&, "@i_tchq", 0, SQLVARCHAR, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tipo_chequera", True, " Ok... Consulta de chequeras") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If
    
    ' Ayuda de Lotes
    Case "sp_lotes"
         PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_sig", 0, SQLINT2, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "496"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_lotes", True, " Ok... Consulta de Lotes") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If
    ' Ayuda de Areas del banco
    Case "sp_area"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, 6510
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "F"  'Cambio LHo, antiguo valor H; 08252007
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, 1
        PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGFilial
        PMPasoValores sqlconn&, "@i_area_padre", 0, SQLINT4, 250
        PMPasoValores sqlconn&, "@i_area", 0, SQLINT4, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_conta", "sp_area", True, " Ok... Consulta de áreas") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If
    Case "sp_tr_persnat_ach"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "613"
         PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2, VGFilial
         PMPasoValores sqlconn&, "@i_cta_ach", 0, SQLINT4, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
         
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_persnat_ach", True, " Ok... Consulta de Cuentas Autorizadas ACH") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If
    Case "sp_tr_empresa_ach"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "609"
        PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "H"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT2, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2, (VGFilial)
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_empresa_ach", True, " Ok... Consulta de empresas ACH") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If
    Case "sp_tr_banco_ach"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "605"
        PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "H"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2, VGFilial
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_banco_ach", True, " Ok... Consulta de Bancos ACH") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If
    Case "sp_cons_ach_general_A"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "639"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "R"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2, (VGFilial)
        PMPasoValores sqlconn&, "@i_secuencial", 0, SQLFLT8, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_ach_general", True, " Ok... Consulta de archivos ingresados en ACH") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
        End If
    Case "sp_pro_transaccion"
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15020"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "9"
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VGProductoConta
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "R"
            PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
            PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT4, Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_pro_transaccion", True, " OK... Consulta de Productos COBIS") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
            End If
    Case "sp_perfil"
            VTUb2 = InStr(VTUb1% + 1, FCatalogo!lstCatalogo.Text, Chr$(9))
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6907"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "2"
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VGProductoConta
            PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGFilial
            If VTUb2 <> 0 Then
                PMPasoValores sqlconn&, "@i_perfil1", 0, SQLVARCHAR, Mid$(FCatalogo!lstCatalogo.Text, VTUb1% + 1, VTUb2% - VTUb1% - 1)
            Else
                PMPasoValores sqlconn&, "@i_perfil1", 0, SQLVARCHAR, Mid$(FCatalogo!lstCatalogo.Text, VTUb1% + 1, Len(FCatalogo!lstCatalogo.Text) - VTUb1% + 1)
            End If
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_conta", "sp_perfil", True, " OK... Consulta de Productos COBIS") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
            End If
    Case "" '' Es un catálogo
        cmdSiguientes.Enabled = False
    End Select
    If VGOperacion$ <> "" Then
    If Val(lstCatalogo.ListCount) Mod 20 = 0 Then
        cmdSiguientes.Enabled = True
    Else
        cmdSiguientes.Enabled = False
    End If
    End If
End Sub

Private Sub Form_Activate()
'*********************************************************
'PROPOSITO: Permite activar o desactivar el boton de
'           siguientes de la lista de ayuda seleccionada
'INPUT:     ninguna
'OUTPUT:    ninguna
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    PMLoadResStrings Me
    PMLoadResIcons Me

    If lstCatalogo.ListCount < 20 Then
        cmdSiguientes.Enabled = False
    Else
        cmdSiguientes.Enabled = True
    End If
    If (lstCatalogo.ListIndex = -1) And (lstCatalogo.ListCount > 0) Then
      lstCatalogo.ListIndex = 0
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
Dim VTUb2 As Integer

    If KeyAscii% = 27 Then
        VGACatalogo.Codigo$ = ""
        VGACatalogo.Descripcion$ = ""
        Unload FCatalogo
    Else
        If KeyAscii% = 13 Then
            If FCatalogo!lstCatalogo.ListCount <> 0 Then
                VTUb1% = InStr(1, lstCatalogo.Text, Chr$(9))
                VGACatalogo.Codigo$ = Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
                VTUb2 = InStr(VTUb1% + 1, FCatalogo!lstCatalogo.Text, Chr$(9))
                If VTUb2% <> 0 Then
                    VGACatalogo.Descripcion$ = Mid$(FCatalogo!lstCatalogo.Text, VTUb1% + 1, VTUb2% - VTUb1% - 1)
                Else
                    VGACatalogo.Descripcion$ = Mid$(FCatalogo!lstCatalogo.Text, VTUb1% + 1, Len(FCatalogo!lstCatalogo.Text) - VTUb1% + 1)
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
'PROPOSITO: Permite seleccionar un dato de la lista de
'           ayuda que se encuentra activa
'INPUT:     ninguna
'OUTPUT:    ninguna
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    Dim VTUb2 As Integer
    
    If FCatalogo!lstCatalogo.ListCount <> 0 Then
        VTUb1% = InStr(1, lstCatalogo.Text, Chr$(9))
        VGACatalogo.Codigo$ = Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
        VTUb2% = InStr(VTUb1% + 1, FCatalogo!lstCatalogo.Text, Chr$(9))
        If VTUb2% <> 0 Then
            VGACatalogo.Descripcion$ = Mid$(FCatalogo!lstCatalogo.Text, VTUb1% + 1, VTUb2% - VTUb1% - 1)
        Else
            VGACatalogo.Descripcion$ = Mid$(FCatalogo!lstCatalogo.Text, VTUb1% + 1, Len(FCatalogo!lstCatalogo.Text) - VTUb1% + 1)
        End If
    Else
        VGACatalogo.Codigo$ = ""
        VGACatalogo.Descripcion$ = ""
    End If
    Unload FCatalogo
End Sub


