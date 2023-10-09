VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FConsultaCta 
   Appearance      =   0  'Flat
   Caption         =   "Personalización Cuentas "
   ClientHeight    =   5310
   ClientLeft      =   150
   ClientTop       =   1815
   ClientWidth     =   9300
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
   Icon            =   "FCONCTA1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5310
   ScaleWidth      =   9300
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Limpiar"
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
      Index           =   3
      Left            =   8400
      Picture         =   "FCONCTA1.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   3000
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   3
      Left            =   1455
      MaxLength       =   10
      TabIndex        =   23
      Top             =   1260
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1440
      MaxLength       =   4
      TabIndex        =   0
      Top             =   960
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Transmitir"
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
      Index           =   0
      Left            =   8400
      Picture         =   "FCONCTA1.frx":0670
      Style           =   1  'Graphical
      TabIndex        =   2
      Tag             =   "4068"
      Top             =   3780
      Width           =   870
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1440
      MaxLength       =   10
      TabIndex        =   5
      Top             =   360
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1440
      MaxLength       =   10
      TabIndex        =   6
      Top             =   660
      Width           =   930
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   1605
      Index           =   1
      Left            =   30
      TabIndex        =   8
      Top             =   3690
      Width           =   8265
      _Version        =   65536
      _ExtentX        =   14579
      _ExtentY        =   2831
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
   Begin VB.CommandButton cmdBoton 
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
      Index           =   1
      Left            =   8400
      Picture         =   "FCONCTA1.frx":09D6
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   4530
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
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
      Index           =   2
      Left            =   8400
      Picture         =   "FCONCTA1.frx":0D3C
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   30
      Width           =   875
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   1605
      Index           =   0
      Left            =   30
      TabIndex        =   7
      Top             =   1860
      Width           =   8265
      _Version        =   65536
      _ExtentX        =   14579
      _ExtentY        =   2831
      _StockProps     =   77
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rubro:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   90
      TabIndex        =   24
      Top             =   1290
      Width           =   585
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   7
      Left            =   2385
      TabIndex        =   22
      Top             =   1260
      Width           =   5820
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   2385
      TabIndex        =   18
      Top             =   960
      Width           =   5820
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   90
      TabIndex        =   21
      Top             =   990
      Width           =   765
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   5
      Left            =   1440
      TabIndex        =   20
      Top             =   60
      Width           =   1875
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "No. de Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   90
      TabIndex        =   19
      Top             =   90
      Width           =   1305
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   4350
      TabIndex        =   15
      Top             =   60
      Visible         =   0   'False
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   5310
      TabIndex        =   16
      Top             =   60
      Visible         =   0   'False
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   6270
      TabIndex        =   17
      Top             =   60
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -30
      X2              =   8310
      Y1              =   1620
      Y2              =   1620
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Categoría:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   90
      TabIndex        =   9
      Top             =   690
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   90
      TabIndex        =   14
      Top             =   390
      Width           =   1305
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2385
      TabIndex        =   13
      Top             =   360
      Width           =   5820
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valores de Servicios Contratados:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   30
      TabIndex        =   12
      Top             =   1680
      Width           =   2895
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2385
      TabIndex        =   11
      Top             =   660
      Width           =   5820
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicios Personalizables:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   30
      TabIndex        =   10
      Top             =   3480
      Width           =   2235
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8340
      X2              =   8340
      Y1              =   0
      Y2              =   5310
   End
End
Attribute VB_Name = "FConsultaCta"
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

Dim VLTipo As String
Dim VLMoneda As String
Dim VLCol As Integer
Dim VLRow As Integer
Dim VLPaso As Integer

Private Sub cmdBoton_Click(Index As Integer)
Dim i%
Dim VTFilas1%
Dim VTServicio1$
Dim VTRango1$
Dim VTFilas2%
Dim VTServicio2$
Dim VTRango2$
    
 Select Case Index%
 Case 0 'Transmitir
    For i% = 1 To grdServicios(1).Rows - 1
        grdServicios(1).Row = i%
        
        grdServicios(1).Col = grdServicios(1).Cols - 3
        'Valida que las fechas de vencimiento sean validas
        If Len(grdServicios(1).Text) > 0 Then
            If Not FMVerFormato((grdServicios(1).Text), VGFormatoFecha$) Then
                MsgBox "Formato de fecha no válido", 0 + 16, "Mensaje de Error"
                grdServicios(1).Text = ""
                Exit Sub
            End If
            If IsDate(grdServicios(1).Text) = False Or _
                FMDateDiff("d", Format$(grdServicios(1).Text, "mm/dd/yyyy"), VGFecha$, "mm/dd/yyyy") > 0 Then
                'Mensaje de Error
                MsgBox "Fecha Incorrecta", 0 + 16, "Mensaje de Error"
                grdServicios(1).Text = ""
                Exit Sub
            End If
            grdServicios(1).Col = grdServicios(1).Cols - 2
            If Len(grdServicios(1).Text) > 0 Then
                grdServicios(1).Col = grdServicios(1).Cols - 1
                If Len(grdServicios(1).Text) > 0 Then
                         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4068" 'Ojo Cambiar transaccion
                         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "T"
                         PMPasoValores sqlconn&, "@i_tipo_default", 0, SQLCHAR, "C"
                         PMPasoValores sqlconn&, "@i_rol", 0, SQLCHAR, "1"
                         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, lblDescripcion(4).Caption
                         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, VGCuenta$
                         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
                         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, lblDescripcion(1).Caption
                         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(0).Text
                        grdServicios(1).Col = 3
                         PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, grdServicios(1).Text
                        grdServicios(1).Col = 5
                         PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, grdServicios(1).Text
                        grdServicios(1).Col = 7
                         PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, grdServicios(1).Text
                        
                        grdServicios(1).Col = 9
                         PMPasoValores sqlconn&, "@i_rango", 0, SQLINT4, grdServicios(1).Text
                        grdServicios(1).Col = grdServicios(1).Cols - 3
                         PMPasoValores sqlconn&, "@i_fecha_venc", 0, SQLDATETIME, Format$(grdServicios(1).Text, "mm/dd/yyyy") 'VGFormatoFecha$)
                        grdServicios(1).Col = grdServicios(1).Cols - 2
                         PMPasoValores sqlconn&, "@i_tipo_variacion", 0, SQLCHAR, grdServicios(1).Text 'P o M
                        grdServicios(1).Col = grdServicios(1).Cols - 1
                         PMPasoValores sqlconn&, "@i_valor_con", 0, SQLFLT8&, (grdServicios(1).Text)
                         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Creación de Valor Contratado") Then
                             PMChequea sqlconn&
                            VGPersonaliza% = True
                            'cmdBoton(0).Enabled = False
                        Else
                            grdServicios(1).Col = 2
                            MsgBox "Fallo el registro " + (grdServicios(1).Text), 0 + 16, "Mensaje de Error"
                        End If
                Else
                    MsgBox "Digite Un Valor, para Registro de la fila: " + CStr(i%), 0 + 16, "Mensaje de Error"
                    grdServicios(1).Col = grdServicios(1).Cols - 1
                    grdServicios(1).SetFocus
                    Exit Sub

                End If
            Else
                    MsgBox "Debe Digitar M/P, para Registro de la fila: " + CStr(i%), 0 + 16, "Mensaje de Error"
                    grdServicios(1).Col = grdServicios(1).Cols - 2
                    grdServicios(1).SetFocus
                    Exit Sub
            End If
            grdServicios(1).Col = grdServicios(1).Cols - 3
            grdServicios(1).Text = ""
            grdServicios(1).Col = grdServicios(1).Cols - 2
            grdServicios(1).Text = ""
            grdServicios(1).Col = grdServicios(1).Cols - 1
            grdServicios(1).Text = ""
        Else
            grdServicios(1).Col = grdServicios(1).Cols - 2
                If Len(grdServicios(1).Text) > 0 Then
                    grdServicios(1).Col = grdServicios(1).Cols - 1
                        If Len(grdServicios(1).Text) > 0 Then
                                MsgBox "Debe Ingresar Fecha Vencimiento, para Registro de la fila: " + CStr(i%), 0 + 16, "Mensaje de Error"
                                grdServicios(1).Col = grdServicios(1).Cols - 3
                                grdServicios(1).SetFocus
                                Exit Sub
                        Else
                                MsgBox "Digite Un Valor, para Registro de la fila: " + CStr(i%), 0 + 16, "Mensaje de Error"
                                grdServicios(1).Col = grdServicios(1).Cols - 1
                                grdServicios(1).SetFocus
                                Exit Sub
                        End If
                Else
                    MsgBox "Debe Digitar M/P, para Registro de la fila: " + CStr(i%), 0 + 16, "Mensaje de Error"
                    grdServicios(1).Col = grdServicios(1).Cols - 2
                    grdServicios(1).SetFocus
                    Exit Sub
                End If
        End If
    Next i%
        
 Case 1 'Salir
    
    Unload FConsultaCta
 
 Case 2 'Buscar
        VTFilas1% = VGMaxRows%
        VTServicio1$ = "0"
        VTRango1$ = "0"
        While VTFilas1% = VGMaxRows%
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4070"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
             PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, VTServicio1$
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT2, VTRango1$
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, lblDescripcion(1).Caption
             PMPasoValores sqlconn&, "@i_tipo_default", 0, SQLCHAR, "C"
             PMPasoValores sqlconn&, "@i_rol", 0, SQLCHAR, FPersoCuenta.txtCampo(2).Text
             PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, lblDescripcion(4).Caption
             PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, VGCuenta$
             PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, txtCampo(3).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Ok... Consulta de Servicios") Then
                If VTServicio1$ = "0" And VTRango1$ = "0" Then
                     PMMapeaGrid sqlconn&, grdServicios(0), False
                Else
                     PMMapeaGrid sqlconn&, grdServicios(0), True
                End If
                 PMChequea sqlconn&
                'VTFilas1% = Val(grdServicios(0).Tag)
    
                grdServicios(0).Col = 1
                grdServicios(0).Row = grdServicios(0).Rows - 1
                VTServicio1$ = grdServicios(0).Text
                grdServicios(0).Col = 3
                grdServicios(0).Row = grdServicios(0).Rows - 1
                VTRango1$ = grdServicios(0).Text
            
            ' Determinar que existan servicions bancarios
                If Val(grdServicios(0).Tag) > 0 Then
                    grdServicios(0).ColAlignment(4) = 1
                    grdServicios(0).ColAlignment(5) = 1
                    grdServicios(0).ColAlignment(7) = 1
                    
                End If
    
            End If
            VTFilas1% = Val(grdServicios(0).Tag)
    Wend
    grdServicios(0).Row = 1

    VTFilas2% = 20
    VTServicio2$ = "0"
    VTRango2$ = "0"
        

    While VTFilas2% = 20
    
         
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4069"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
         PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, VTServicio2$
         PMPasoValores sqlconn&, "@i_rango", 0, SQLINT2, VTRango2$
         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, lblDescripcion(4).Caption
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, lblDescripcion(1).Caption
         PMPasoValores sqlconn&, "@i_tipo_default", 0, SQLCHAR, "C"
         PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, txtCampo(3).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Ok... Consulta de Servicios") Then
            If VTServicio2$ = "0" And VTRango2$ = "0" Then
                 PMMapeaGrid sqlconn&, grdServicios(1), False
    
                If Val(grdServicios(1).Tag) > 0 Then
                    grdServicios(1).Cols = grdServicios(1).Cols + 3
                    'grdServicios(1).FixedRows = grdServicios(1).Cols - 2
                    grdServicios(1).Row = 0
                    grdServicios(1).Col = grdServicios(1).Cols - 3
                    grdServicios(1).Text = "FECHA VENC"
                    grdServicios(1).Col = grdServicios(1).Cols - 2
                    grdServicios(1).Text = "M / P"
                    grdServicios(1).Col = grdServicios(1).Cols - 1
                    grdServicios(1).Text = "VALOR"
                    grdServicios(1).ColWidth(grdServicios(1).Cols - 3) = 1800
                    grdServicios(1).ColWidth(grdServicios(1).Cols - 2) = 500
                    grdServicios(1).ColWidth(grdServicios(1).Cols - 1) = 1800
                    cmdBoton(0).Enabled = True
                End If
            Else
                 PMMapeaGrid sqlconn&, grdServicios(1), True
            End If
             PMChequea sqlconn&
            VTFilas2% = Val(grdServicios(1).Tag)
    
            grdServicios(1).Col = 3
            grdServicios(1).Row = grdServicios(1).Rows - 1
            VTServicio2$ = grdServicios(1).Text
            grdServicios(1).Col = 9
            grdServicios(1).Row = grdServicios(1).Rows - 1
            VTRango2$ = grdServicios(1).Text
    
            ' Determinar que existan servicios bancarios
            If Val(grdServicios(1).Tag) > 0 Then
                    grdServicios(1).ColWidth(1) = 1
                    grdServicios(1).ColWidth(3) = 1
                    grdServicios(1).ColWidth(4) = 1
                    grdServicios(1).ColWidth(5) = 1
                    grdServicios(1).ColWidth(6) = 1
                    grdServicios(1).ColWidth(10) = 1
                    grdServicios(1).ColAlignment(7) = 1
                    grdServicios(1).ColAlignment(8) = 1
                    grdServicios(1).ColAlignment(9) = 1
            End If
    
            End If
            VTFilas2% = Val(grdServicios(1).Tag)
    Wend
    grdServicios(1).Row = 1

 Case 3 'Limpiar
    txtCampo(1).Text = ""
    txtCampo(3).Text = ""
    lblDescripcion(6).Caption = ""
    lblDescripcion(7).Caption = ""
    cmdBoton(2).Enabled = False
    cmdBoton(0).Enabled = False
    grdServicios(0).Rows = 2
    grdServicios(0).Cols = 2
    grdServicios(0).Row = 0
    grdServicios(0).Col = 1
    grdServicios(0).Text = ""
    grdServicios(0).Row = 1
    grdServicios(0).Col = 0
    grdServicios(0).Text = ""
    grdServicios(0).Row = 1
    grdServicios(0).Col = 1
    grdServicios(0).Text = ""
    grdServicios(0).ColWidth(1) = grdServicios(0).ColWidth(0)
    grdServicios(1).Rows = 2
    grdServicios(1).Cols = 2
    grdServicios(1).Row = 0
    grdServicios(1).Col = 1
    grdServicios(1).Text = ""
    grdServicios(1).Row = 1
    grdServicios(1).Col = 0
    grdServicios(1).Text = ""
    grdServicios(1).Row = 1
    grdServicios(1).Col = 1
    grdServicios(1).Text = ""
    grdServicios(1).ColWidth(1) = grdServicios(1).ColWidth(0)
    txtCampo(1).Enabled = True
    txtCampo(1).SetFocus
 End Select

End Sub

Private Sub Form_Activate()
    txtCampo(0).Enabled = False
    txtCampo(2).Enabled = False
 
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(2)
    
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
'31/Enero/95  A.Rodríguez            Emisión Inicial
'01/Febrero/95 A.Rodríguez           Modificaciones
'*********************************************************
FConsultaCta.Left = 85
FConsultaCta.Top = 1000
FConsultaCta.Width = 9420
FConsultaCta.Height = 5900

If lblDescripcion(1).Caption <> "" Then
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4044"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(1).Caption
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", True, "") Then
         PMMapeaVariable sqlconn&, VLMoneda$
         PMChequea sqlconn&
    End If
    End If
    cmdBoton(0).Enabled = False
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

Private Sub grdServicios_Click(Index As Integer)
    If Index% = 1 Then
        VLRow% = grdServicios(1).Row
        VLCol% = grdServicios(1).Col
    End If
    If Index = 1 And VLCol% > 0 Then
        grdServicios(1).Col = VLCol%
    End If
End Sub

Private Sub grdServicios_GotFocus(Index As Integer)
    Select Case Index%
        Case 0
            FPrincipal.pnlHelpLine.Caption = "Servicios Contratados"
        Case 1
            FPrincipal.pnlHelpLine.Caption = "Servicios Disponibles"
    End Select
End Sub

Private Sub grdServicios_KeyPress(Index As Integer, KeyAscii As Integer)
' Modificacion: 10-Dic-2002
' Se agrega código para manejar Fecha de Vencimiento de la exoneracion
' Especificacion CC00080 - version Banco Agrario (Colombia)
Dim VTRow%
Dim VTCol%
Dim VTDato$
    If Index% = 1 Then
        
        If VLCol% > 0 Then
            grdServicios(1).Col = VLCol%
        End If
        
        VTRow% = grdServicios(1).Row
        VTCol% = grdServicios(1).Col
        grdServicios(1).Row = 1
        grdServicios(1).Col = 1
        If grdServicios(1).Text = "" Then
            Exit Sub
        End If
        grdServicios(1).Row = VTRow%
        grdServicios(1).Col = VTCol%
        
        ' Columna Fecha de Vencimiento de la exoneracion
        If grdServicios(1).Col = grdServicios(1).Cols - 3 Then
            ' rutina de Backspace
            If (KeyAscii% = 8) Then
                If Len(grdServicios(1).Text) > 0 Then
                    grdServicios(1).Text = Mid$(grdServicios(1).Text, 1, Len(grdServicios(1).Text) - 1)
                    VLRow% = grdServicios(1).Row
                    VLCol% = grdServicios(1).Col
                    grdServicios_Click (1)
                    Exit Sub
                End If
            End If
            
            ' Validar que el KeyAscii% solo sea numeros o "/" (formato fecha)
            If ((KeyAscii% < 48) Or (KeyAscii% > 57)) And (Chr$(KeyAscii%)) <> "/" Then
                KeyAscii% = 0
                VLRow% = grdServicios(1).Row
                VLCol% = grdServicios(1).Col
                grdServicios_Click (1)
                Exit Sub
            Else
                grdServicios(1).Text = grdServicios(1).Text & Chr$(KeyAscii%)
            End If
            
        ' Columna de Tipo de Dato
        ElseIf grdServicios(1).Col = grdServicios(1).Cols - 2 Then
           
            ' rutina de Backspace
            If (KeyAscii% = 8) Then
                If Len(grdServicios(1).Text) > 0 Then
                    grdServicios(1).Text = Mid$(grdServicios(1).Text, 1, Len(grdServicios(1).Text) - 1)
                    VLRow% = grdServicios(1).Row
                    VLCol% = grdServicios(1).Col
                    grdServicios_Click (1)
                    Exit Sub
                End If
            End If
            
            If (Len(grdServicios(1).Text) > 0) Then
                KeyAscii% = 0
                Exit Sub
            End If

            ' Validar que el KeyAscii% solo sea "M" o P" con Uppercase
            If (UCase$(Chr$(KeyAscii%)) = "P" Or UCase$(Chr$(KeyAscii%)) = "M") Then
                KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
                grdServicios(1).Text = (UCase$(Chr$(KeyAscii%)))
                VLTipo$ = grdServicios(1).Text
            Else
                KeyAscii% = 0
            End If

        ' Columna de valores
        ElseIf grdServicios(1).Col = grdServicios(1).Cols - 1 Then
            
            VTCol% = grdServicios(1).Col
            grdServicios(1).Col = grdServicios(1).Cols - 2
            VTDato$ = grdServicios(1).Text
            grdServicios(1).Col = VTCol%
    
            'Solo permite ingresar si se ha ingresado algo en la columna anterior
            If VLTipo$ = "" Then
                KeyAscii% = 0
                MsgBox "El tipo de dato es mandatorio", 0 + 16, "Mensaje de Error"
                VLRow% = grdServicios(1).Row
                VLCol% = grdServicios(1).Col
                grdServicios_Click (1)
                Exit Sub
            End If

            'Rutina de Backspace
            If (KeyAscii% = 8) Then
                If Len(grdServicios(1).Text) > 0 Then
                    grdServicios(1).Text = Mid$(grdServicios(1).Text, 1, Len(grdServicios(1).Text) - 1)
                    VLRow% = grdServicios(1).Row
                    VLCol% = grdServicios(1).Col
                    grdServicios_Click (1)
                    Exit Sub
                End If
            End If
            
            'Valida que se pueda ingresar decimales de acuerdo al tipo de dato y la moneda
            If VLTipo$ = "P" Then
                If ((KeyAscii% < 48) Or (KeyAscii% > 57)) And (Chr$(KeyAscii%)) <> "." And UCase$(Chr$(KeyAscii%)) <> "+" And UCase$(Chr$(KeyAscii%)) <> "-" Then
                    KeyAscii% = 0
                    VLRow% = grdServicios(1).Row
                    VLCol% = grdServicios(1).Col
                    grdServicios_Click (1)
                    Exit Sub
                Else
                    grdServicios(1).Text = grdServicios(1).Text & Chr$(KeyAscii%)
                End If
            Else
                If VLMoneda$ = "N" And VLTipo$ = "M" And VTDato$ = "M" Then
                    
                    If ((KeyAscii% < 48) Or (KeyAscii% > 57)) And UCase$(Chr$(KeyAscii%)) <> "+" And UCase$(Chr$(KeyAscii%)) <> "-" Then
                            KeyAscii% = 0
                            VLRow% = grdServicios(1).Row
                            VLCol% = grdServicios(1).Col
                            grdServicios_Click (1)
                            Exit Sub
                    Else
                        grdServicios(1).Text = grdServicios(1).Text & Chr$(KeyAscii%)
                        
                    End If
                Else
                    If ((KeyAscii% < 48) Or (KeyAscii% > 57)) And (Chr$(KeyAscii%)) <> "." And UCase$(Chr$(KeyAscii%)) <> "+" And UCase$(Chr$(KeyAscii%)) <> "-" Then
                            KeyAscii% = 0
                            VLRow% = grdServicios(1).Row
                            VLCol% = grdServicios(1).Col
                            grdServicios_Click (1)
                            Exit Sub
                    Else
                        grdServicios(1).Text = grdServicios(1).Text & Chr$(KeyAscii%)
                        
                    End If
    
                End If
            End If
            
            'Valida que no tenga más de un punto
            If Len(grdServicios(1).Text) > 0 And (grdServicios(1).Text <> "." And grdServicios(1).Text <> "+" And grdServicios(1).Text <> "-") Then
                If IsNumeric(grdServicios(1).Text) = False Or (InStr(1, grdServicios(1).Text, "+") > 1) Or (InStr(1, grdServicios(1).Text, "-") > 1) Then
                   'Mensaje de Error
                    MsgBox "Valor Incorrecto", 0 + 16, "Mensaje de Error"
                    grdServicios(1).Text = ""
                    VLRow% = grdServicios(1).Row
                    VLCol% = grdServicios(1).Col
                    grdServicios_Click (1)
                    Exit Sub
                End If
            End If

            'Valida que sea menor que 100 si es porcentaje
            If VLTipo$ = "P" Then
                If Abs(Val(Format$(grdServicios(1).Text))) > 100 Then
                    MsgBox "Valor Incorrecto", 0 + 16, "Mensaje de Error"
                    grdServicios(1).Text = ""
                    VLRow% = grdServicios(1).Row
                    VLCol% = grdServicios(1).Col
                    grdServicios_Click (1)
                    Exit Sub
                End If
            End If
            
           If Len(grdServicios(1).Text) > 13 Then
                   'Mensaje de Error
                    MsgBox "Valor Incorrecto", 0 + 16, "Mensaje de Error"
                    grdServicios(1).Text = ""
                    VLRow% = grdServicios(1).Row
                    VLCol% = grdServicios(1).Col
                    grdServicios_Click (1)
                    Exit Sub
           End If
            
        End If
        
        VLCol% = grdServicios(1).Col
        grdServicios_Click (1)
        
    End If
End Sub

Private Sub grdServicios_KeyUp(Index As Integer, KeyCode As Integer, Shift As Integer)
    Select Case Index%
    Case 0, 1
        grdServicios(Index%).Col = 0
        grdServicios(Index%).SelStartCol = 1
        grdServicios(Index%).SelEndCol = grdServicios(Index%).Cols - 1
        If grdServicios(Index%).Row = 0 Then
            grdServicios(Index%).SelStartRow = 1
            grdServicios(Index%).SelEndRow = 1
        Else
            grdServicios(Index%).SelStartRow = grdServicios(Index%).Row
            grdServicios(Index%).SelEndRow = grdServicios(Index%).Row
        End If
    End Select
End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Servicio disponible y rubro [F5 Ayuda]"
    End Select
End Sub
    Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Load FCatalogoServ
        If Index% = 1 Then 'Consulta de servicios
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4069"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "0"
             PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, ""
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, "0"
             PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Creación de Valor Contratado") Then
                 PMMapeaGrid sqlconn&, FCatalogoServ.grdRegistros, False
                 PMChequea sqlconn&
                VGOperacion$ = "operacionHCons"
                FCatalogoServ.Show 1
                VLPaso% = True
                If txtCampo(1).Text <> "" Then
                    cmdBoton(2).Enabled = True
                    cmdBoton(2).SetFocus
                    txtCampo(1).Enabled = False
                End If
            End If
        End If
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 1
       If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii% = 0
       End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
    Case 1
        If VLPaso% = False Then
        Load FCatalogoServ
            If txtCampo(1).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4069"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H2"
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "0"
                 PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, ""
                 PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, "0"
                 PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, "0"
                 PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(1).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Creación de Valor Contratado") Then
                     PMMapeaGrid sqlconn&, FCatalogoServ.grdRegistros, False
                     PMChequea sqlconn&
                    VGOperacion$ = "operacionH2Cons"
                    If FCatalogoServ.grdRegistros.Row > 1 Then
                        FCatalogoServ.Show 1
                        If txtCampo(1).Text <> "" Then
                            cmdBoton(2).Enabled = True
                            txtCampo(1).Enabled = False
                        End If
                    Else
                        MsgBox "No Existe Ese Servicio", 0 + 16, "Mensaje de Error"
                        txtCampo(1).Text = ""
                        txtCampo(1).SetFocus
                        Exit Sub
                    End If
                End If
            End If
        End If
    End Select
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2, 3
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


