VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FAyudaSubserv2 
   Appearance      =   0  'Flat
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Búsqueda Rubros de Servicios"
   ClientHeight    =   4170
   ClientLeft      =   975
   ClientTop       =   2115
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
   Icon            =   "FHLPSUB2.frx":0000
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
      Picture         =   "FHLPSUB2.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   3390
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
      Picture         =   "FHLPSUB2.frx":0670
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   2625
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
      Picture         =   "FHLPSUB2.frx":09D6
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   1860
      Width           =   900
   End
   Begin MSGrid.Grid grdSubserv 
      Height          =   3885
      Left            =   15
      TabIndex        =   0
      Top             =   270
      Width           =   6780
      _Version        =   65536
      _ExtentX        =   11960
      _ExtentY        =   6853
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
      Caption         =   "Lista de Rubros de Servicios:"
      ForeColor       =   &H00800000&
      Height          =   210
      Left            =   30
      TabIndex        =   4
      Top             =   15
      Width           =   2565
   End
End
Attribute VB_Name = "FAyudaSubserv2"
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
Dim VLTxtCampo5$
Dim VTFilas%
Dim VTCodigo$
Dim VTRubro$
    Select Case Index%
    Case 0 'Busca los primeros 20

        If VGForma$ = "FMantenLinea2" Then
            VLTxtCampo5$ = FMantenLinea2.txtCampo(5).Text
        Else
            If VGForma$ = "FConsulMas" Then
                VLTxtCampo5$ = FConsulMas.txtCampo(5).Text
            Else
                If VGForma$ = "FCosEsp" Then
                    VLTxtCampo5$ = FCosEsp.txtCampo(3).Text
                Else
                    If VGForma$ = "FPersoEspecial" Then
                        VLTxtCampo5$ = FPersoEspecial.txtCampo(0).Text
                    Else
                        If VGForma$ = "FManteEspecial" Then
                            VLTxtCampo5$ = FManteEspecial.txtCampo(0).Text
                        Else
                            VLTxtCampo5$ = FConsulMas2.txtCampo(5).Text
                        End If
                    End If
                End If
            End If
        End If
            
        
        
        If VLTxtCampo5$ <> "" Then
         
            VTFilas% = VGMaxRows%
            'VTCodigo$ = FMantenLinea2!txtCampo(5).Text
            VTCodigo$ = VLTxtCampo5$
            VTRubro$ = "0"
            While VTFilas% = VGMaxRows%
            
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4039"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H2"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, VTCodigo$
             PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, VTRubro$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_cosub", True, "Ok... Consulta de Detalle de Servicios") Then
                If VTRubro$ = "0" Then
                     PMMapeaGrid sqlconn&, grdSubserv, False
                Else
                     PMMapeaGrid sqlconn&, grdSubserv, True
                End If
                 PMChequea sqlconn&
                'VTFilas% = Val(grdServicios.Tag)
        
                grdSubserv.Col = 3
                grdSubserv.Row = grdSubserv.Rows - 1
                VTRubro$ = grdSubserv.Text
        
                ' Determinar que existan servicions bancarios
                If Val(grdSubserv.Tag) > 0 Then
                    cmdEscoger.Enabled = True
                Else
                    If VTRubro$ = "0" Then
                        FRubros.lblDescripcion(1).Caption = ""
                        FRubros.lblDescripcion(11).Caption = ""
                        FRubros.lblDescripcion(5).Caption = ""
                    End If
                End If
        
                End If
                VTFilas% = Val(grdSubserv.Tag)
            Wend
            grdSubserv.Row = 1
        
        Else

            VTFilas% = VGMaxRows%
            VTCodigo$ = "0"
            VTRubro$ = "0"
            While VTFilas% = VGMaxRows%
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4039"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H1"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, VTCodigo$
                 PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, VTRubro$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_cosub", True, "Ok... Consulta de Detalle de Servicios") Then
                    If VTCodigo$ = "0" Then
                         PMMapeaGrid sqlconn&, grdSubserv, False
                    Else
                         PMMapeaGrid sqlconn&, grdSubserv, True
                    End If
                     PMChequea sqlconn&
                    'VTFilas% = Val(grdServicios.Tag)
            
                    grdSubserv.Col = 3
                    grdSubserv.Row = grdSubserv.Rows - 1
                    VTCodigo$ = grdSubserv.Text
                    
                    grdSubserv.Col = 4
                    grdSubserv.Row = grdSubserv.Rows - 1
                    VTRubro$ = grdSubserv.Text
            
                    ' Determinar que existan servicions bancarios
                    If Val(grdSubserv.Tag) > 0 Then
                        cmdEscoger.Enabled = True
                    End If
                End If
                VTFilas% = Val(grdSubserv.Tag)
            Wend
            grdSubserv.Row = 1
         End If
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
    grdSubserv_DblClick
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
    ReDim VGDetalle(1)
    Unload FAyudaSubserv2
    'FAyudaSubserv.Hide
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
 'ReDim VGDetalle(1)
    FPrincipal.pnlHelpLine.Caption = "Búsqueda de Servicios Disponibles"
    If VGForma$ = "FMantenLinea2" Or VGForma$ = "FConsulMas" Or VGForma$ = "" Then
        cmdBuscar(0).Visible = False
    End If
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

Private Sub grdSubserv_Click()
    grdSubserv.Col = 0
    grdSubserv.SelStartCol = 1
    grdSubserv.SelEndCol = grdSubserv.Cols - 1
    If grdSubserv.Row = 0 Then
        grdSubserv.SelStartRow = 1
        grdSubserv.SelEndRow = 1
    Else
        grdSubserv.SelStartRow = grdSubserv.Row
        grdSubserv.SelEndRow = grdSubserv.Row
    End If
End Sub

Private Sub grdSubserv_DblClick()
Dim VTRow%
    VTRow% = grdSubserv.Row

    grdSubserv.Row = 1
    grdSubserv.Col = 1

    If grdSubserv.Text <> "" Then
        grdSubserv.Row = VTRow%
        PMMarcarDetalle
    End If

End Sub

Private Sub grdSubserv_KeyUp(KeyCode As Integer, Shift As Integer)
    grdSubserv.Col = 0
    grdSubserv.SelStartCol = 1
    grdSubserv.SelEndCol = grdSubserv.Cols - 1
    If grdSubserv.Row = 0 Then
        grdSubserv.SelStartRow = 1
        grdSubserv.SelEndRow = 1
    Else
        grdSubserv.SelStartRow = grdSubserv.Row
        grdSubserv.SelEndRow = grdSubserv.Row
    End If

End Sub

Private Sub PMMarcarDetalle()
Dim VTCols%
Dim i%
    VTCols% = grdSubserv.Cols - 1
    ReDim VGDetalle(0 To VTCols%)
    VGDetalle(0) = "S"
    For i% = 1 To grdSubserv.Cols - 1
        grdSubserv.Col = i%
        VGDetalle(i%) = grdSubserv.Text
    Next i%
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
    Unload FAyudaSubserv2
   

End Sub



