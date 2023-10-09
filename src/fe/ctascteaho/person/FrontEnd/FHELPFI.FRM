VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FAyudaProdFinal 
   Appearance      =   0  'Flat
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Búsqueda Productos Finales"
   ClientHeight    =   4170
   ClientLeft      =   1020
   ClientTop       =   1845
   ClientWidth     =   7770
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Icon            =   "FHELPFI.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4170
   ScaleWidth      =   7770
   Begin VB.CommandButton cmdSalir 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Left            =   6855
      Picture         =   "FHELPFI.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   3405
      Width           =   900
   End
   Begin VB.CommandButton cmdEscoger 
      Caption         =   "&Escoger"
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
      Height          =   750
      Left            =   6855
      Picture         =   "FHELPFI.frx":0670
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   2640
      Width           =   900
   End
   Begin VB.CommandButton cmdBuscar 
      Caption         =   "&Buscar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   0
      Left            =   6855
      Picture         =   "FHELPFI.frx":09D6
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   1875
      Width           =   900
   End
   Begin MSGrid.Grid grdProductos 
      Height          =   3915
      Left            =   15
      TabIndex        =   3
      Top             =   240
      Width           =   6780
      _Version        =   65536
      _ExtentX        =   11960
      _ExtentY        =   6906
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   6825
      X2              =   6825
      Y1              =   15
      Y2              =   4170
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      Caption         =   "Lista de Productos Finales:"
      ForeColor       =   &H00800000&
      Height          =   210
      Index           =   0
      Left            =   15
      TabIndex        =   4
      Top             =   15
      Width           =   2325
   End
End
Attribute VB_Name = "FAyudaProdFinal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010

'*********************************************************
'   Archivo:        FHELPFI.FRM
'   Producto:       Personalización
'   Diseñado por:   Angela Rodríguez
'   Fecha de Documentación: 26/Ene/95
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
' Forma: FAyudaProdFinal
' Descripción: Esta forma permite la consulta de Productos
'              Finales, y permite del resultado de la
'              consulta escoger los datos correspondientes
'              a un producto final. La forma de comunicación con la
'              rutina desde la cual fue llamada esta búsque-
'              da es a través del Arreglo de Strings
'              VGProductos() el cual debe ser declarado en el
'              módulo global de la aplicación en la que esta
'              forma se utiliza.
'              Si un producto fue escogido -> VGProducto(0) <> ""
'              Si no se escogió producto -> VGProducto(0) = ""
' VARIABLES GLOBALES:
'           ServerName$         nombre del servidor
'           VGProducto()        arreglo global que guarda
'                               en forma temporal los campos
'                               del registro seleccionado
' MODULOS:
'           MHELPG.BAS = Rutinas para usar la ventana de ayuda
'*********************************************************

'Variables Locales

Private Sub cmdBuscar_Click(Index As Integer)
'*********************************************************
'Objetivo:  Rutina para buscar productos finales
'           . Esta rutina sirve a los
'           botones buscar y siguientes
'Input   :  Index       identifica al botón.
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'27/Ene/94  A.Rodríguez         Emisión Inicial
'*********************************************************
Dim VTFilas%
Dim VTCodigo$
Dim VTProducto$
Dim VTMoneda$
    Select Case Index%
    Case 0 'Busca los primeros 20 productos finales
        Select Case VGProd$
        Case "R"
        
            If FRubros.txtCampo(2).Text <> "" Then
                VTFilas% = VGMaxRows%
                VTCodigo$ = FRubros.txtCampo(2).Text
                VTProducto$ = "0"
                VTMoneda$ = "0"
                While VTFilas% = VGMaxRows%
                
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4077"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                     PMPasoValores sqlconn&, "@i_cod_merc", 0, SQLINT2, VTCodigo$
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VTProducto$
                     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VTMoneda$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Productos") Then
                        If VTProducto$ = "0" Then
                             PMMapeaGrid sqlconn&, grdProductos, False
                        Else
                             PMMapeaGrid sqlconn&, grdProductos, True
                        End If
                         PMChequea sqlconn&
                        VTFilas% = Val(grdProductos.Tag)
                        If Val(grdProductos.Tag) > 0 Then
                            cmdEscoger.Enabled = True
                        Else
                            If VTProducto$ = "0" Then
    
                                FRubros.lblDescripcion(0).Caption = ""
                                FRubros.lblDescripcion(2).Caption = ""
                                FRubros.lblDescripcion(4).Caption = ""
                                FRubros.lblDescripcion(6).Caption = ""
                                FRubros.lblDescripcion(7).Caption = ""
                                FRubros.lblDescripcion(8).Caption = ""
                                FRubros.lblDescripcion(10).Caption = ""
                            End If
                        End If
                    
                        grdProductos.Col = 2
                        grdProductos.Row = grdProductos.Rows - 1
                        VTProducto$ = grdProductos.Text
                
                        grdProductos.Col = 4
                        grdProductos.Row = grdProductos.Rows - 1
                        VTMoneda$ = grdProductos.Text
                        
                        ' Determinar que existan servicions bancarios
                    Else
                        
                        Exit Sub
                        FRubros.txtCampo(2).Text = ""
                    End If
            
                Wend
                grdProductos.Row = 1
            Else
                VTFilas% = VGMaxRows%
                VTCodigo$ = "0"
                VTProducto$ = "0"
                VTMoneda$ = "0"
                While VTFilas% = VGMaxRows%
                
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                     PMPasoValores sqlconn&, "@i_cod_merc", 0, SQLINT2, VTCodigo$
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VTProducto$
                     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VTMoneda$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Productos") Then
                    If VTCodigo$ = "0" Then
                         PMMapeaGrid sqlconn&, grdProductos, False
                    Else
                         PMMapeaGrid sqlconn&, grdProductos, True
                    End If
                     PMChequea sqlconn&
                    VTFilas% = Val(grdProductos.Tag)
            
                    If Val(grdProductos.Tag) > 0 Then
                        cmdEscoger.Enabled = True
                    End If
                    
                    grdProductos.Col = 2
                    grdProductos.Row = grdProductos.Rows - 1
                    VTCodigo$ = grdProductos.Text
            
                    grdProductos.Col = 4
                    grdProductos.Row = grdProductos.Rows - 1
                    VTProducto$ = grdProductos.Text
            
                    grdProductos.Col = 6
                    grdProductos.Row = grdProductos.Rows - 1
                    VTMoneda$ = grdProductos.Text
                    
                    ' Determinar que existan servicions bancarios
            
                    End If
            
                Wend
                grdProductos.Row = 1
             
        
            End If

            
        Case "C"
            If FContratacion.txtCampo(2).Text <> "" Then
                VTFilas% = VGMaxRows%
                VTCodigo$ = FContratacion.txtCampo(2).Text
                VTProducto$ = "0"
                VTMoneda$ = "0"
                While VTFilas% = VGMaxRows%
                
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4077"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H2"
                     PMPasoValores sqlconn&, "@i_cod_merc", 0, SQLINT2, VTCodigo$
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VTProducto$
                     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VTMoneda$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Productos") Then
                        If VTProducto$ = "0" Then
                             PMMapeaGrid sqlconn&, grdProductos, False
                        Else
                             PMMapeaGrid sqlconn&, grdProductos, True
                        End If
                         PMChequea sqlconn&
                        VTFilas% = Val(grdProductos.Tag)
                        If Val(grdProductos.Tag) > 0 Then
                            cmdEscoger.Enabled = True
                        Else
                            If VTProducto$ = "0" Then

                                FContratacion.lblDescripcion(2).Caption = ""
                                FContratacion.lblDescripcion(3).Caption = ""
                                FContratacion.lblDescripcion(4).Caption = ""
                                FContratacion.lblDescripcion(6).Caption = ""
                            End If
                        End If
                    
                        grdProductos.Col = 2
                        grdProductos.Row = grdProductos.Rows - 1
                        VTProducto$ = grdProductos.Text
                
                        grdProductos.Col = 4
                        grdProductos.Row = grdProductos.Rows - 1
                        VTMoneda$ = grdProductos.Text
                    
                    ' Determinar que existan servicions bancarios
                    Else
                        FContratacion.txtCampo(2).Text = ""
                        Exit Sub
                    End If
            
                Wend
                grdProductos.Row = 1
        Else
            VTFilas% = VGMaxRows%
            VTCodigo$ = "0"
            VTProducto$ = "0"
            VTMoneda$ = "0"
            While VTFilas% = VGMaxRows%
            
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S2"
                 PMPasoValores sqlconn&, "@i_cod_merc", 0, SQLINT2, VTCodigo$
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VTProducto$
                 PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VTMoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Productos") Then
                If VTCodigo$ = "0" Then
                     PMMapeaGrid sqlconn&, grdProductos, False
                Else
                     PMMapeaGrid sqlconn&, grdProductos, True
                End If
                 PMChequea sqlconn&
                VTFilas% = Val(grdProductos.Tag)
        
                If Val(grdProductos.Tag) > 0 Then
                    cmdEscoger.Enabled = True
                End If
                
                grdProductos.Col = 2
                grdProductos.Row = grdProductos.Rows - 1
                VTCodigo$ = grdProductos.Text
        
                grdProductos.Col = 4
                grdProductos.Row = grdProductos.Rows - 1
                VTProducto$ = grdProductos.Text
        
                grdProductos.Col = 6
                grdProductos.Row = grdProductos.Rows - 1
                VTMoneda$ = grdProductos.Text
                
                ' Determinar que existan servicions bancarios
        
                End If
        
            Wend
            grdProductos.Row = 1
            
    
        End If
    End Select
End Select
End Sub

Private Sub cmdBuscar_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  Index       identifica al botón.
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    Select Case Index
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Buscar Grupos Económicos de acuerdo a especificaciones"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Buscar el siguiente conjunto de Grupos Económicos"
    End Select
End Sub

Private Sub cmdEscoger_Click()
'*********************************************************
'Objetivo:  Esta rutina pasa el contenido de la línea del
'           grid escogida al arreglo global VGBusqueda pa-
'           ra que, al salir de esta forma, se pueda tener
'           los datos de un cliente.
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    grdProductos_DblClick
End Sub

Private Sub cmdEscoger_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlHelpLine.Caption = "Escoger un Grupo Económico"
End Sub

Private Sub cmdSalir_Click()
'*********************************************************
'Objetivo:  Inicializa el arreglo global VGBusqueda y ocul-
'           ta la forma (no la descarga)
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    ReDim VGProducto(1)
    cmdEscoger.Enabled = False
    Unload FAyudaProdFinal
    'FAyudaProdFinal.Hide
End Sub

Private Sub cmdSalir_GotFocus()
    FPrincipal.pnlHelpLine.Caption = "Salir de la Forma de Búsqueda"
End Sub

Private Sub Form_Load()
'*********************************************************
 'DESCRIPCION:  Esta forma despliega la ayuda via F5
 '              para los productos finales
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'27/Enero/95  A.Rodríguez            Emisión Inicial
'*********************************************************
 'ReDim VGProducto(1)
 FPrincipal.pnlHelpLine.Caption = "Busqueda de Productos Finales"
 cmdBuscar_Click (0)
 
 End Sub

Private Sub Form_Unload(Cancel As Integer)
'*********************************************************
'Objetivo:  Limpia las líneas de Mensaje y Transaccion
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdProductos_Click()
    grdProductos.Col = 0
    grdProductos.SelStartCol = 1
    grdProductos.SelEndCol = grdProductos.Cols - 1
    If grdProductos.Row = 0 Then
        grdProductos.SelStartRow = 1
        grdProductos.SelEndRow = 1
    Else
        grdProductos.SelStartRow = grdProductos.Row
        grdProductos.SelEndRow = grdProductos.Row
    End If
    
End Sub

Private Sub grdProductos_DblClick()
Dim VTRow%
    VTRow% = grdProductos.Row

    grdProductos.Row = 1
    grdProductos.Col = 1

    If grdProductos.Text <> "" Then
        grdProductos.Row = VTRow%
        PMMarcarProducto
    End If
End Sub

Private Sub grdProductos_KeyUp(KeyCode As Integer, Shift As Integer)
    grdProductos.Col = 0
    grdProductos.SelStartCol = 1
    grdProductos.SelEndCol = grdProductos.Cols - 1
    If grdProductos.Row = 0 Then
        grdProductos.SelStartRow = 1
        grdProductos.SelEndRow = 1
    Else
        grdProductos.SelStartRow = grdProductos.Row
        grdProductos.SelEndRow = grdProductos.Row
    End If


End Sub

Private Sub PMMarcarProducto()
Dim VTCols%
Dim i%
    VTCols% = grdProductos.Cols - 1
    ReDim VGProducto(0 To VTCols%)
    VGProducto(0) = "P"
    For i% = 1 To grdProductos.Cols - 1
        grdProductos.Col = i%
        VGProducto(i%) = grdProductos.Text
    Next i%
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
    Unload FAyudaProdFinal
    'FAyudaProdFinal.Hide
End Sub



