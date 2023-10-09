VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FRegistros 
   Appearance      =   0  'Flat
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Registros Seleccionados"
   ClientHeight    =   3240
   ClientLeft      =   3765
   ClientTop       =   1290
   ClientWidth     =   5535
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
   ScaleWidth      =   5535
   Begin MSGrid.Grid grdRegistros 
      Height          =   2835
      Left            =   15
      TabIndex        =   1
      Top             =   15
      Width           =   5505
      _Version        =   65536
      _ExtentX        =   9711
      _ExtentY        =   5001
      _StockProps     =   77
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.CommandButton cmdSiguientes 
      Appearance      =   0  'Flat
      Caption         =   "&Siguientes"
      Enabled         =   0   'False
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
      TabIndex        =   0
      Top             =   2865
      Width           =   5505
   End
End
Attribute VB_Name = "FRegistros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   ARCHIVO:                FREGISTR.FRM
'   NOMBRE LOGICO:          FRegistros
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
'                       MODIFICACIONES
'   FECHA              AUTOR          RAZON
'   6-Junio-1994      --------        Emision Inicial
'*********************************************************
Option Explicit
Dim VTBanco As String
Dim VTCiudad As String
Dim VTOficina As String
Private Sub cmdSiguientes_Click()
'*********************************************************
'PROPOSITO: Permite obtener los siguientes registros
'           de la lista de ayuda seleccionada
' INPUT   : ninguna
' OUTPUT  : ninguna
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 6-Junio-1994      --------        Emision Inicial
'*************************************************************
    Dim VTUltimo As String
    Dim VLUltimo As String
    Select Case VGOperacion$
        Case "sp_tranhistoricos" 'tipos de transaciones monetarias y servicios
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2576"
            PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, VGProducto$
            PMPasoValores sqlconn&, "@i_qry", 0, SQLCHAR, "T"
            PMPasoValores sqlconn&, "@i_tipotrn", 0, SQLINT4, "0"
            PMPasoValores sqlconn&, "@i_tipohis", 0, SQLCHAR, VGTipoHis$
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
            PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, (grdRegistros.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_qry_tranms", True, " Ok... Consulta de Tipos de Transacciones Monetarias") Then
                PMMapeaGrid sqlconn&, FRegistros!grdRegistros, True
                PMChequea sqlconn&
                If Val(grdRegistros.Tag) = VGMaxRows% Then
                    cmdSiguientes.Enabled = True
                Else
                    cmdSiguientes.Enabled = False
                End If
                grdRegistros.Row = 1
            End If
            PMChequea sqlconn&
            grdRegistros.ColWidth(1) = 650
            grdRegistros.ColWidth(2) = 4500
        Case "sp_rem_ayuda"  'Números de Carta y Corresponsales
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "447"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VGHelpRem$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT1, VGOficina$
            grdRegistros.Col = 1
            grdRegistros.Row = grdRegistros.Rows - 1
            VTUltimo$ = Trim$(grdRegistros.Text)
            If VGHelpRem$ = "N" Then
                VTUltimo$ = Mid$(VTUltimo$, 6, (Len(VTUltimo$) - 5))
            Else
                VTUltimo$ = Left$(VLUltimo$, 2)
            End If
            PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, VTUltimo$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_ayuda", True, " Ok... Consulta de Número de Carta Remesa") Then
                PMMapeaGrid sqlconn&, FRegistros!grdRegistros, True
                PMChequea sqlconn&
                If Val(grdRegistros.Tag) = VGMaxRows% Then
                    cmdSiguientes.Enabled = True
                Else
                    cmdSiguientes.Enabled = False
                End If
                grdRegistros.Row = 1
            End If
        
        Case "sp_tr_crea_rutayt"  'Localidades Ruta y transito
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2587"
            PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "L"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_localidad", 0, SQLINT2, "0"
            PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, (grdRegistros.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_rutayt", True, "Ok... Eliminación de Ruta y Tránsito") Then
                PMMapeaGrid sqlconn&, FRegistros!grdRegistros, True
                PMChequea sqlconn&
            End If
            If Val(grdRegistros.Tag) = VGMaxRows% Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
            grdRegistros.Row = 1
        
        Case "sp_cat_bancos"  'Catalogo de Bancos
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "452"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, (grdRegistros.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cat_bancos", True, "Ok... Eliminación de Ruta y Tránsito") Then
                PMMapeaGrid sqlconn&, FRegistros!grdRegistros, True
                PMChequea sqlconn&
            End If
            If Val(grdRegistros.Tag) = VGMaxRows% Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
            grdRegistros.Row = 1
    
        Case "sp_tr_empresa_ach"  'Empresas ACH
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2, VGFilial$
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "609"
            PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT2, (grdRegistros.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_empresa_ach", True, "Ok... Empresas ACH") Then
                PMMapeaGrid sqlconn&, FRegistros!grdRegistros, True
                PMChequea sqlconn&
            End If
            If Val(grdRegistros.Tag) = VGMaxRows% Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
            grdRegistros.Row = 1
    
        Case "sp_tr_banco_ach"  'Bancos ACH
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "605"
            PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT4, VGFilial$
            PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, (grdRegistros.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_banco_ach", True, "Ok... Bancos ACH") Then
                PMMapeaGrid sqlconn&, FRegistros!grdRegistros, True
                PMChequea sqlconn&
            End If
            If Val(grdRegistros.Tag) = VGMaxRows% Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
            grdRegistros.Row = 1

        Case "sp_centro_canje"  'Ciudades centro de canje
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, (grdRegistros.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, "Ok... Consulta ciudades") Then
                PMMapeaGrid sqlconn&, FRegistros!grdRegistros, True
                PMChequea sqlconn&
            End If
            If Val(grdRegistros.Tag) = VGMaxRows% Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
            grdRegistros.Row = 1
    
       Case "sp_centro_canje1"  'Centros de canje definidos
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "H1"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, (grdRegistros.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, "Ok... Consulta ciudades") Then
                PMMapeaGrid sqlconn&, FRegistros!grdRegistros, True
                PMChequea sqlconn&
            End If
            If Val(grdRegistros.Tag) = VGMaxRows% Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
            grdRegistros.Row = 1
    End Select
End Sub

Private Sub Form_Activate()
'*********************************************************
'PROPOSITO: Permite activar o desactivar el boton de
'           siguientes de la lista de ayuda seleccionada
' INPUT   : ninguna
' OUTPUT  : ninguna
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    
        grdRegistros.Col = 0
        If Val(grdRegistros.Tag) = VGMaxRows% Then
            cmdSiguientes.Enabled = True 'Boton Siguientes boton 5 = buscar
            grdRegistros.Row = 1
        Else
            cmdSiguientes.Enabled = False
        End If
        VGACatalogo.Descripcion$ = ""
        VGACatalogo.Codigo$ = ""
        PLAjustaGrid grdRegistros, Me
End Sub
Private Sub Form_KeyPress(KeyAscii As Integer)
    If KeyAscii% = 27 Then
       VGACatalogo.Descripcion$ = ""
       VGACatalogo.Codigo$ = ""
    Else
        If KeyAscii% = 13 Then
           If grdRegistros.Rows > 1 Then
              Select Case VGOperacion$
                 Case "sp_tranhistoricos"
                    grdRegistros.Col = 1
                    VGACatalogo.Codigo$ = grdRegistros.Text
                    grdRegistros.Col = 2
                    VGACatalogo.Descripcion$ = grdRegistros.Text
                 Case "sp_rem_ayuda"
                    If VGHelpRem$ = "N" Then
                       grdRegistros.Col = 1
                       VGACatalogo.Codigo$ = grdRegistros.Text
                    End If
                    If VGHelpRem$ = "C" Then
                       grdRegistros.Col = 1
                       VTBanco$ = Left$(Trim$(grdRegistros.Text), 3)
                       VTOficina$ = Mid$(Trim$(grdRegistros.Text), 4, 3)
                       VTCiudad$ = Right$(Trim$(grdRegistros.Text), 6)
                       VGACatalogo.Codigo$ = VTBanco$ & "-" & VTOficina$ & "-" & VTCiudad$
                       grdRegistros.Col = 2
                       VGACatalogo.Descripcion$ = grdRegistros.Text
                    End If
                 Case "sp_tr_crea_rutayt"
                    grdRegistros.Col = 1
                    VGACatalogo.Codigo$ = grdRegistros.Text
                    grdRegistros.Col = 2
                    VGACatalogo.Descripcion$ = grdRegistros.Text
                 Case "sp_cat_bancos"
                    grdRegistros.Col = 1
                    VGACatalogo.Codigo$ = grdRegistros.Text
                    grdRegistros.Col = 2
                    VGACatalogo.Descripcion$ = grdRegistros.Text
                 Case "sp_cons_user_caja"
                    grdRegistros.Col = 1
                    VGACatalogo.Descripcion$ = grdRegistros.Text
              End Select
             Else
                VGACatalogo.Codigo$ = ""
                VGACatalogo.Descripcion$ = ""
           End If
        End If
     End If
    Unload FRegistros
End Sub

Private Sub grdRegistros_Click()
    With grdRegistros
        'Comentariado por LHO, no permite el ordenamiento con un registro; 24082007
        'If .Row = 1 And .SelStartRow = 1 And .SelEndRow = .Rows - 1 Then 'ordenar
            'PMOrdenarGrid grdRegistros, .Col
       'End If
        .Col = 0
        .SelStartCol = 1
        .SelEndCol = .Cols - 1
        If .Row = 0 Then
            .SelStartRow = 1
            .SelEndRow = 1
        Else
            .SelStartRow = .Row
            .SelEndRow = .Row
        End If
    End With
End Sub
Private Sub grdregistros_DblClick()
    If grdRegistros.Rows > 1 Then
        Select Case VGOperacion$
            Case "sp_tranhistoricos"
                grdRegistros.Col = 1
                VGACatalogo.Codigo$ = grdRegistros.Text
                grdRegistros.Col = 2
                VGACatalogo.Descripcion$ = grdRegistros.Text
            
            Case "sp_rem_ayuda"
                If VGHelpRem$ = "N" Then
                    grdRegistros.Col = 1
                    VGACatalogo.Codigo$ = grdRegistros.Text
                End If
                If VGHelpRem$ = "C" Then
                    grdRegistros.Col = 1
                    VTBanco$ = Left$(Trim$(grdRegistros.Text), 4)
                    VTOficina$ = Mid$(Trim$(grdRegistros.Text), 5, 4)
                    VTCiudad$ = Right$(Trim$(grdRegistros.Text), 4)
                    VGACatalogo.Codigo$ = VTBanco$ & "-" & VTOficina$ & "-" & VTCiudad$
                    grdRegistros.Col = 2
                    VGACatalogo.Descripcion$ = grdRegistros.Text
                End If
            
            Case "sp_tr_crea_rutayt"
                grdRegistros.Col = 1
                VGACatalogo.Codigo$ = grdRegistros.Text
                grdRegistros.Col = 2
                VGACatalogo.Descripcion$ = grdRegistros.Text
            
            Case "sp_tr_crea_rutayt", "sp_cat_bancos", "sp_tr_empresa_ach", "sp_tr_banco_ach"
                grdRegistros.Col = 1
                VGACatalogo.Codigo$ = grdRegistros.Text
                grdRegistros.Col = 2
                VGACatalogo.Descripcion$ = grdRegistros.Text
            
            Case "sp_cons_user_caja"
                grdRegistros.Col = 1
                VGACatalogo.Descripcion$ = grdRegistros.Text

            Case "sp_centro_canje", "sp_centro_canje1"
              grdRegistros.Col = 1
              VGACatalogo.Codigo$ = grdRegistros.Text
              grdRegistros.Col = 2
              VGACatalogo.Descripcion$ = grdRegistros.Text
            
            Case "sp_prodfin3" 'REQ 322 F5 PARA PRODUCTOS FINALES DESDE TADMIN
                grdRegistros.Col = 1 'profinal
                VGACatalogo.Codigo$ = grdRegistros.Text
                grdRegistros.Col = 2 ' descripcion
                VGACatalogo.Descripcion$ = grdRegistros.Text
                
            Case "sp_hp_sucursal" 'REQ 322 F5 PARA SUCURSALES
                grdRegistros.Col = 1 'cod
                VGACatalogo.Codigo$ = grdRegistros.Text
                grdRegistros.Col = 2 ' desde
                VGACatalogo.Descripcion$ = grdRegistros.Text
 
            Case Else
                grdRegistros.Col = 1
                VGACatalogo.Codigo$ = grdRegistros.Text
                grdRegistros.Col = 2
                VGACatalogo.Descripcion$ = grdRegistros.Text
        End Select
    Else
        VGACatalogo.Codigo$ = ""
        VGACatalogo.Descripcion$ = ""
    End If
    Unload FRegistros
 End Sub
Private Sub grdRegistros_KeyUp(Keycode As Integer, Shift As Integer)
    grdRegistros.Col = 0
    grdRegistros.SelStartCol = 1
    grdRegistros.SelEndCol = grdRegistros.Cols - 1
    If grdRegistros.Row = 0 Then
        grdRegistros.SelStartRow = 1
        grdRegistros.SelEndRow = 1
    Else
        grdRegistros.SelStartRow = grdRegistros.Row
        grdRegistros.SelEndRow = grdRegistros.Row
    End If
    
End Sub


