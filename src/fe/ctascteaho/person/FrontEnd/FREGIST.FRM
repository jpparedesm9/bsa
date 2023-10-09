VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FRegistros 
   Appearance      =   0  'Flat
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Registros Seleccionados"
   ClientHeight    =   3225
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
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3225
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
    Select Case VGOperacion$
    
    
    ' Ayuda de Filiales
    Case "sp_filial"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, grdRegistros.Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_filial", True, "Ok... Consulta de la filiales") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
             PMChequea sqlconn&
        End If
    ' Ayuda de Oficinas
    Case "sp_oficina"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, grdRegistros.Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_oficina", True, "Ok... Consulta de oficinas") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
             PMChequea sqlconn&
        End If
    ' Ayuda de Monedas
    Case "sp_moneda"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, grdRegistros.Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_moneda", True, "Ok... Consulta de monedas") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
             PMChequea sqlconn&
            If Val(grdRegistros.Tag) = VGMaxRows% Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
            grdRegistros.Row = 1

        End If
    ' Ayuda de Tipos de chequeras
    
    Case "sp_help_costos"
     Select Case VGTipo$
        Case "S"
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4058"
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "S"
                PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, FConCostos.txtCampo(0).Text
               grdRegistros.Row = grdRegistros.Rows - 1
               grdRegistros.Col = 1
                PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT4, grdRegistros.Text
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_costos", True, "Ok...Consulta de Servicios") Then
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                     PMChequea sqlconn&
                    If Val(grdRegistros.Tag) = VGMaxRows% Then
                        cmdSiguientes.Enabled = True
                    Else
                        cmdSiguientes.Enabled = False
                    End If
                    grdRegistros.Row = 1
                End If
        

        Case "C"
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4058"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "C"
                 'PMPasoValores SqlConn&, "@i_servicio", 0, SQLINT2, FEliCosto!txtCampo(3).Text
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                 PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, grdRegistros.Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_costos", True, "Ok...Consulta de Servicios") Then
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                     PMChequea sqlconn&
                    If Val(grdRegistros.Tag) = VGMaxRows% Then
                        cmdSiguientes.Enabled = True
                    Else
                        cmdSiguientes.Enabled = False
                    End If
                    grdRegistros.Row = 1
                End If
            
        End Select
    Case "sp_prod_bancario"
                
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4002"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, grdRegistros.Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", True, "") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                 PMChequea sqlconn&
                If Val(grdRegistros.Tag) = VGMaxRows% Then
                    cmdSiguientes.Enabled = True
                Else
                    cmdSiguientes.Enabled = False
                End If
                grdRegistros.Row = 1
            End If

    Case "sp_valor_contratado"
            
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4074"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, FConsultaPer.txtCampo(0).Text
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
             PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, grdRegistros.Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_valor_contratado", True, "Ok...Consulta de Servicios") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                 PMChequea sqlconn&
                If Val(grdRegistros.Tag) = VGMaxRows% Then
                    cmdSiguientes.Enabled = True
                Else
                    cmdSiguientes.Enabled = False
                End If
                
            End If

    Case "sp_corango_pe"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4048"
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
         PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, (grdRegistros.Text)
         PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, FMantenimiento.txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_corango_pe", True, "Ok...Consulta de Servicios") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
             PMChequea sqlconn&
        If Val(grdRegistros.Tag) = VGMaxRows% Then
            cmdSiguientes.Enabled = True
        Else
            cmdSiguientes.Enabled = False
        End If
        End If

    Case "sp_help_rubros"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4046"
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, (grdRegistros.Text)
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, CStr(VGSucursalSig%)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rubros", True, "Ok...Consulta de Servicios") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
             PMChequea sqlconn&
            If Val(grdRegistros.Tag) = VGMaxRows% Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
            grdRegistros.Row = 1
        End If
          
        
    Case "sp_mercado"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4023"
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, (grdRegistros.Text)
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, FTrprobaen.txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mercado", True, "Ok... Consulta de Productos") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
             PMChequea sqlconn&
            If Val(grdRegistros.Tag) = VGMaxRows% Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
            grdRegistros.Row = 1
        End If
     Case "sp_help_serv_pe"
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4031"
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, (grdRegistros.Text)
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_serv_pe", True, "Ok... Consulta de Servicio") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                 PMChequea sqlconn&
                If Val(grdRegistros.Tag) = VGMaxRows% Then
                    cmdSiguientes.Enabled = True
                Else
                    cmdSiguientes.Enabled = False
                End If
                grdRegistros.Row = 1
            End If
     Case "sp_prodfin"
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4012"
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
             PMPasoValores sqlconn&, "@i_cod_merc", 0, SQLINT2, (grdRegistros.Text)
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Mercado") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                 PMChequea sqlconn&
                If Val(grdRegistros.Tag) = VGMaxRows% Then
                    cmdSiguientes.Enabled = True
                Else
                    cmdSiguientes.Enabled = False
                End If
                grdRegistros.Row = 1
            End If
     Case "sp_help_rango_pe" 'tipo y descripcion del rango
            Exit Sub
     Case "sp_help_cosub"
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4039"
             grdRegistros.Row = grdRegistros.Rows - 1
             grdRegistros.Col = 1
              PMPasoValores sqlconn&, "@i_cod_serv", 0, SQLINT2, (grdRegistros.Text)
             grdRegistros.Col = 2
              PMPasoValores sqlconn&, "@i_cod_detalle", 0, SQLCHAR, (grdRegistros.Text)
              PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
              PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_cosub", True, "Ok... Consulta de Detalle de Servicios") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                 PMChequea sqlconn&
                If Val(grdRegistros.Tag) = VGMaxRows% Then
                    cmdSiguientes.Enabled = True
                Else
                    cmdSiguientes.Enabled = False
                End If
                grdRegistros.Row = 1
            End If
        Case "sp_promon"
                If VGTipo$ = "H" Then
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4075"
                Else
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4076"
                     PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
                End If
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, (grdRegistros.Text)
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 2
                 PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, (grdRegistros.Text)
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, VGTipo$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", True, " Consulta del producto ") Then
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                     PMChequea sqlconn&
                    If Val(grdRegistros.Tag) = VGMaxRows% Then
                        cmdSiguientes.Enabled = True
                    Else
                        cmdSiguientes.Enabled = False
                    End If
                    grdRegistros.Row = 1
                End If

     Case "sp_cons_personalizacion"
           
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4067"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
             PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, grdRegistros.Text
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_personalizacion", True, "Ok...Consulta de Servicios") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                 PMChequea sqlconn&
                If Val(grdRegistros.Tag) = VGMaxRows% Then
                    cmdSiguientes.Enabled = True
                Else
                    cmdSiguientes.Enabled = False
                End If
                grdRegistros.Row = 1
             End If
     
     Case "sp_autoriza_trn_caja"
           
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "731"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "N"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
        PMPasoValores sqlconn&, "@i_tran", 0, SQLINT4&, grdRegistros.Text '"0"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_autoriza_trn_caja", True, "Ok... Consulta de Transacciones") Then
            PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
            PMChequea sqlconn&
            If Val(grdRegistros.Tag) = VGMaxRows% Then
                cmdSiguientes.Enabled = True
            Else
                cmdSiguientes.Enabled = False
            End If
                grdRegistros.Row = 1
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
    Dim i%
        grdRegistros.Col = 0
        If Val(grdRegistros.Tag) = VGMaxRows% Then
            cmdSiguientes.Enabled = True 'Boton Siguientes boton 5 = buscar
            grdRegistros.Row = 1
            
        Else
            cmdSiguientes.Enabled = False
        End If
        VGACatalogo.Descripcion$ = ""
        VGACatalogo.Codigo$ = ""
        For i% = 0 To 10
        VGValores(i%) = ""
        Next i%

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
Dim i%
    If KeyAscii% = 27 Then
        VGACatalogo.Descripcion$ = ""
        VGACatalogo.Codigo$ = ""
        For i% = 0 To 10
        VGValores(i%) = ""
        Next i%
        VGOperacion$ = ""
        VGTipo$ = ""
        Unload FRegistros
    Else
        If KeyAscii% = 13 Then
            PLEscoger
        End If
    End If
End Sub

Private Sub grdRegistros_Click()
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

Private Sub grdRegistros_DblClick()
    PLEscoger
End Sub

Private Sub grdRegistros_KeyUp(KeyCode As Integer, Shift As Integer)
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

Private Sub PLEscoger()
Dim i%
    Select Case VGOperacion$
    Case "sp_help_costos"
        Select Case VGTipo$
        Case "R"
            If grdRegistros.Rows > 1 Then
                grdRegistros.Col = 1
                VGValores(1) = grdRegistros.Text
                grdRegistros.Col = 2
                VGValores(2) = grdRegistros.Text
                grdRegistros.Col = 3
                VGValores(3) = grdRegistros.Text
                grdRegistros.Col = 4
                VGValores(4) = grdRegistros.Text
                VGOperacion$ = ""
                Unload FRegistros
                Exit Sub
            Else
                For i% = 0 To 10
                VGValores(i%) = ""
                Next i%
                VGOperacion$ = ""
                Unload FRegistros
                Exit Sub
            End If
            
        Case "C"
            If grdRegistros.Rows > 1 Then
                grdRegistros.Col = 1
                VGACatalogo.Codigo$ = grdRegistros.Text
                grdRegistros.Col = 2
                VGACatalogo.Descripcion$ = grdRegistros.Text
                VGOperacion$ = ""
                Unload FRegistros
                Exit Sub
            Else
                VGACatalogo.Codigo$ = ""
                VGACatalogo.Descripcion$ = ""
                VGOperacion$ = ""
                Unload FRegistros
                Exit Sub
            End If
        
        Case "S"
            If grdRegistros.Rows > 1 Then
                grdRegistros.Col = 1
                VGValores(1) = grdRegistros.Text
                grdRegistros.Col = 2
                VGValores(2) = grdRegistros.Text
                grdRegistros.Col = 3
                VGValores(3) = grdRegistros.Text
                grdRegistros.Col = 4
                VGValores(4) = grdRegistros.Text
                grdRegistros.Col = 5
                VGValores(5) = grdRegistros.Text
                
                VGOperacion$ = ""
                
                Unload FRegistros
                Exit Sub
            Else
                For i% = 0 To 10
                VGValores(i%) = ""
                Next i%
                VGOperacion$ = ""
                Unload FRegistros
                Exit Sub
            End If
            
        End Select
    
    Case "sp_help_rango_pe"
        Select Case VGTipo$
        Case "T"
            If grdRegistros.Rows > 1 Then
                grdRegistros.Col = 1
                VGValores(1) = grdRegistros.Text
                grdRegistros.Col = 2
                VGValores(2) = grdRegistros.Text
                grdRegistros.Col = 3
                VGValores(3) = grdRegistros.Text
                grdRegistros.Col = 4
                VGValores(4) = grdRegistros.Text
                VGOperacion$ = ""
                Unload FRegistros
                Exit Sub
            Else
                For i% = 0 To 10
                VGValores(i%) = ""
                Next i%
                VGOperacion$ = ""
                Unload FRegistros
                Exit Sub
            End If

        Case "G"
            If grdRegistros.Rows > 1 Then
                grdRegistros.Col = 1
                VGACatalogo.Codigo$ = grdRegistros.Text
                VGOperacion$ = ""
                VGTipo$ = ""
                Unload FRegistros
                Exit Sub
            Else
                VGACatalogo.Codigo$ = ""
                VGOperacion$ = ""
                VGTipo$ = ""
                Unload FRegistros
                Exit Sub
            End If
        End Select

    Case "sp_promon"
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1
            VGValores(1) = grdRegistros.Text
            grdRegistros.Col = 2
            VGValores(2) = grdRegistros.Text
            grdRegistros.Col = 3
            VGValores(3) = grdRegistros.Text
            grdRegistros.Col = 4
            VGValores(4) = grdRegistros.Text
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        Else
            For i% = 0 To 10
            VGValores(i%) = ""
            Next i%
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        End If

    Case "sp_prodfin"
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1 'cod
            VGValores(1) = grdRegistros.Text
            grdRegistros.Col = 2 ' desde
            VGValores(2) = grdRegistros.Text
            grdRegistros.Col = 3 ' hasta
            VGValores(3) = grdRegistros.Text

            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        Else
            For i% = 0 To 10
            VGValores(i%) = ""
            Next i%
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        End If

    Case "sp_prodfin2"
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1 'cod
            VGValores(1) = grdRegistros.Text
            grdRegistros.Col = 2 'desde
            VGValores(2) = grdRegistros.Text
            grdRegistros.Col = 7 'moneda
            VGValores(3) = grdRegistros.Text
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        Else
            For i% = 0 To 10
            VGValores(i%) = ""
            Next i%
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        End If

    Case "sp_prodfin3"
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1 'profinal
            VGValores(1) = grdRegistros.Text
            grdRegistros.Col = 2 ' descripcion
            VGValores(2) = grdRegistros.Text
            grdRegistros.Col = 5 ' producto cobis
            VGValores(5) = grdRegistros.Text

            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        Else
            For i% = 0 To 10
            VGValores(i%) = ""
            Next i%
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        End If


    Case "sp_hp_sucursal"
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1 'cod
            VGValores(1) = grdRegistros.Text
            grdRegistros.Col = 2 ' desde
            VGValores(2) = grdRegistros.Text
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        Else
            For i% = 0 To 10
            VGValores(i%) = ""
            Next i%
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        End If
    
    Case "sp_corango_pe"
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1 'cod
            VGValores(1) = grdRegistros.Text
            grdRegistros.Col = 2 ' desde
            VGValores(2) = grdRegistros.Text
            grdRegistros.Col = 3 ' hasta
            VGValores(3) = grdRegistros.Text
            grdRegistros.Col = 4  ' estado
            VGValores(4) = grdRegistros.Text
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        Else
            For i% = 0 To 10
            VGValores(i%) = ""
            Next i%
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        End If

    Case "sp_help_rubros"
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1 'cod
            VGValores(1) = grdRegistros.Text
            grdRegistros.Col = 2 ' descrip
            VGValores(2) = grdRegistros.Text
            grdRegistros.Col = 3 ' tipo rang
            VGValores(3) = grdRegistros.Text
            grdRegistros.Col = 4 'prod final
            VGValores(4) = grdRegistros.Text
            grdRegistros.Col = 5 ' desc prod final
            VGValores(5) = grdRegistros.Text
            grdRegistros.Col = 6 'tipo dato
            VGValores(6) = grdRegistros.Text
            
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        Else
            For i% = 0 To 10
            VGValores(i%) = ""
            Next i%
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        End If

    Case "sp_cons_personalizacion"
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1 'cod
            VGValores(1) = grdRegistros.Text
            grdRegistros.Col = 2 ' descrip
            VGValores(2) = grdRegistros.Text
            grdRegistros.Col = 3 ' tipo rang
            VGValores(3) = grdRegistros.Text
            
            VGOperacion$ = ""
            
            Unload FRegistros
            Exit Sub
        Else
            For i% = 0 To 10
                VGValores(i%) = ""
            Next i%
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        End If
    
    Case "sp_corango_ma"
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1 ' cod
            VGValores(1) = grdRegistros.Text
            grdRegistros.Col = 2 ' rango 1
            VGValores(2) = grdRegistros.Text
            grdRegistros.Col = 3 ' rango 2
            VGValores(3) = grdRegistros.Text
            
            VGOperacion$ = ""
            
            Unload FRegistros
            Exit Sub
        Else
            For i% = 0 To 10
                VGValores(i%) = ""
            Next i%
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        End If
        
    Case "sp_autoriza_trn_caja"
        If grdRegistros.Rows > 1 Then
            grdRegistros.Col = 1 ' trn
            VGValores(1) = grdRegistros.Text
            grdRegistros.Col = 2 ' desc transaccion
            VGValores(2) = grdRegistros.Text
            
            VGOperacion$ = ""
            
            Unload FRegistros
            Exit Sub
        Else
            For i% = 0 To 10
                VGValores(i%) = ""
            Next i%
            VGOperacion$ = ""
            Unload FRegistros
            Exit Sub
        End If
    End Select
    
    If grdRegistros.Rows > 1 Then
        grdRegistros.Col = 1
        VGACatalogo.Codigo$ = grdRegistros.Text
        grdRegistros.Col = 2
        VGACatalogo.Descripcion$ = grdRegistros.Text
    Else
        VGACatalogo.Codigo$ = ""
        VGACatalogo.Descripcion$ = ""
    End If
    VGOperacion$ = ""
    Unload FRegistros
End Sub



