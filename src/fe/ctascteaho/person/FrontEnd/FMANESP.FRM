VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form FManteEspecial 
   Appearance      =   0  'Flat
   Caption         =   "Mantenimiento de Costos Especiales"
   ClientHeight    =   5310
   ClientLeft      =   60
   ClientTop       =   1830
   ClientWidth     =   9300
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
   Icon            =   "FMANESP.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5310
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Index           =   0
      Left            =   1785
      MaxLength       =   4
      TabIndex        =   0
      Top             =   15
      Width           =   930
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7845
      Picture         =   "FMANESP.frx":030A
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   19
      Top             =   1515
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8070
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   18
      Top             =   1515
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Aprobar"
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
      Height          =   735
      Index           =   0
      Left            =   8400
      Picture         =   "FMANESP.frx":03E4
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4092"
      Top             =   1515
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
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
      Index           =   3
      Left            =   8400
      Picture         =   "FMANESP.frx":074A
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4091"
      Top             =   60
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   2
      Left            =   1755
      MaxLength       =   8
      TabIndex        =   3
      Top             =   1035
      Width           =   1680
   End
   Begin VB.ComboBox cmbPerso 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      ItemData        =   "FMANESP.frx":09AC
      Left            =   1755
      List            =   "FMANESP.frx":09AE
      Sorted          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   720
      Width           =   1680
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
      Index           =   2
      Left            =   8400
      Picture         =   "FMANESP.frx":09B0
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   4530
      Width           =   875
   End
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
      Index           =   1
      Left            =   8400
      Picture         =   "FMANESP.frx":0D16
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   3765
      Width           =   875
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   1515
      Index           =   1
      Left            =   30
      TabIndex        =   15
      Top             =   3735
      Width           =   8265
      _Version        =   65536
      _ExtentX        =   14579
      _ExtentY        =   2672
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   225
      Left            =   1755
      TabIndex        =   5
      Top             =   1035
      Width           =   1665
      _ExtentX        =   2937
      _ExtentY        =   397
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   225
      Left            =   1770
      TabIndex        =   1
      Top             =   495
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   397
      _Version        =   393216
      Appearance      =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   1
      Left            =   1755
      MaxLength       =   7
      TabIndex        =   4
      Top             =   1035
      Width           =   1665
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Imprimir"
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
      Index           =   4
      Left            =   8400
      Picture         =   "FMANESP.frx":107C
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "4091"
      Top             =   3015
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Eliminar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Index           =   5
      Left            =   8400
      Picture         =   "FMANESP.frx":13E2
      Style           =   1  'Graphical
      TabIndex        =   26
      Tag             =   "4092"
      Top             =   2265
      Width           =   870
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   1635
      Index           =   0
      Left            =   45
      TabIndex        =   6
      Top             =   1695
      Width           =   8265
      _Version        =   65536
      _ExtentX        =   14579
      _ExtentY        =   2884
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
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   225
      Index           =   3
      Left            =   1785
      TabIndex        =   25
      Top             =   255
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   225
      Index           =   2
      Left            =   2730
      TabIndex        =   24
      Top             =   255
      Width           =   5565
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rubro:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   0
      Left            =   45
      TabIndex        =   23
      Top             =   315
      Width           =   525
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   225
      Index           =   1
      Left            =   2730
      TabIndex        =   22
      Top             =   15
      Width           =   5565
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio Disponible:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   6
      Left            =   45
      TabIndex        =   21
      Top             =   75
      Width           =   1545
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha Vigencia:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   13
      Left            =   45
      TabIndex        =   20
      Top             =   555
      Width           =   1215
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valores de Costos Personalizados:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   5
      Left            =   45
      TabIndex        =   17
      Top             =   3480
      Width           =   2715
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valores de Costos Generales:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   4
      Left            =   75
      TabIndex        =   16
      Top             =   1455
      Width           =   2295
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8325
      Y1              =   1380
      Y2              =   1380
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Personalización por:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   1
      Left            =   45
      TabIndex        =   12
      Top             =   840
      Width           =   1590
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   225
      Index           =   0
      Left            =   3450
      TabIndex        =   13
      Top             =   1035
      Width           =   4845
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Nro. Cuenta:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   2
      Left            =   45
      TabIndex        =   14
      Top             =   1110
      Width           =   975
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8340
      X2              =   8340
      Y1              =   15
      Y2              =   5325
   End
End
Attribute VB_Name = "FManteEspecial"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
'! removed Dim VLMoneda As String


'variables para guardar en costos personalizados
'! removed Dim VLRubro As String

Dim VLTipo_dato As String
'! removed Dim VLTipo_rango As String

'! removed Dim VLGrupo As String

'! removed Dim VLRango As String

'! removed Dim VLMinimo As Double

'! removed Dim VLMaximo As Double

Dim VLFecha As String
Dim VLAProbar As String
Dim VLFormatoFecha As String


Sub PLTransmitir()
Dim VTConfirmar$
Dim VTVigente$
Dim i%, j%
Dim VTPerson$
Dim VTGeneral$
Dim VTMsg$
        'Validación de Mandatoriedades
        If txtCampo(0).Text = "" Then
            MsgBox "El servicio disponible es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        If mskFecha.ClipText = "" Then
            MsgBox "La fecha de vigencia es obligatoria", 0 + 16, "Mensaje de Error"
            mskFecha.SetFocus
            Exit Sub
        End If
                      
        VTConfirmar$ = "N"
        VTVigente$ = "N"
        grdServicios(0).Row = 1
        grdServicios(0).Col = 1
        If grdServicios(0).Text <> "" Then
            grdServicios(0).Col = 2
            For i% = 1 To grdServicios(0).Rows - 1
                grdServicios(0).Row = i%
                grdServicios(0).Col = 0
                If grdServicios(0).Text = "X" Then
                    grdServicios(0).Col = 2
                    If Mid$(grdServicios(0).Text, 1, 1) = "V" Then
                        VTVigente$ = "V"
                    End If
                    grdServicios(0).Col = 3
                    If Mid$(grdServicios(0).Text, 1, 1) = "A" Then
                        VTConfirmar$ = "A"
                    End If
                End If
            Next i%
        End If
                   
        If VTConfirmar$ = "A" Then
            If VLAProbar$ = "S" Then
                MsgBox "No se puede Aprobar costos ya aprobados", 0 + 16, "Mensaje de Error"
                Exit Sub
            End If
        End If
                   
        If VTVigente$ = "V" Then
            If VLAProbar$ = "N" Then
                MsgBox "No se puede Eliminar costos Vigentes", 0 + 16, "Mensaje de Error"
                Exit Sub
            End If
        End If

        If VLAProbar$ = "S" Then 'Validar eliminacion costos personalizados
            VTPerson$ = "N"
            grdServicios(1).Row = 1
            grdServicios(1).Col = 1
            If grdServicios(1).Text <> "" Then
                grdServicios(1).Col = 2
                For i% = 1 To grdServicios(1).Rows - 1
                    grdServicios(1).Row = i%
                    grdServicios(1).Col = 0
                    If grdServicios(1).Text = "X" Then
                            VTPerson$ = "S"
                    End If
                Next i%
            End If
        
            If VTPerson$ = "S" Then
                MsgBox "No se puede Aprobar valores de costos personalizados", 0 + 16, "Mensaje de Error"
                Exit Sub
            End If
        End If
        
        VTGeneral$ = "N"
        VTPerson$ = "N"
        For j% = 0 To 1
            grdServicios(j%).Col = 0
            For i% = 1 To grdServicios(j%).Rows - 1
                grdServicios(j%).Row = i%
                If grdServicios(j%).Text = "X" Then
                    If j% = 0 Then
                        VTGeneral$ = "G"
                    Else
                        VTPerson$ = "P"
                    End If
                End If
            Next i%
        Next j%
        
        If VLAProbar$ = "S" Then
            VTMsg$ = "APROBAR"
        Else
            VTMsg$ = "ELIMINAR"
        End If
       
        If VTGeneral$ = "N" And VTPerson$ = "N" Then
            MsgBox "Se debe marcar al menos un costo para " + VTMsg$, 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
                      
        If MsgBox("Esta seguro de " + VTMsg$ + " los costos marcados ? ", 4 + 32 + 0, "Mensaje del Sistema") <> 6 Then
            Exit Sub
        Else
            If VTGeneral$ = "G" Then
                For i% = 1 To grdServicios(0).Rows - 1
                    grdServicios(0).Col = 0
                    grdServicios(0).Row = i%
                    If grdServicios(0).Text = "X" Then
                        If VLAProbar$ = "S" Then
                            PMPasoValores sqlconn&, "@i_aprobado", 0, SQLCHAR, "S"
                        Else
                            PMPasoValores sqlconn&, "@i_aprobado", 0, SQLCHAR, "E"
                        End If
    
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4092"
                        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
                        PMPasoValores sqlconn&, "@i_person", 0, SQLCHAR, VTGeneral$
                        grdServicios(0).Col = 1
                        PMPasoValores sqlconn&, "@i_fecha_vigencia", 0, SQLVARCHAR, grdServicios(0).Text
                        grdServicios(0).Col = 4
                        PMPasoValores sqlconn&, "@i_rubro", 0, SQLVARCHAR, grdServicios(0).Text
                        grdServicios(0).Col = 10
                        PMPasoValores sqlconn&, "@i_tipo_dato", 0, SQLCHAR, grdServicios(0).Text
                        grdServicios(0).Col = 13
                        PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT1, grdServicios(0).Text
                        grdServicios(0).Col = 14
                        PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, grdServicios(0).Text
                        grdServicios(0).Col = 15
                        PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, grdServicios(0).Text
                        grdServicios(0).Col = 16
                        PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, grdServicios(0).Text
                        grdServicios(0).Col = 7
                        PMPasoValores sqlconn&, "@i_valor_per", 0, SQLMONEY, grdServicios(0).Text
                        grdServicios(0).Col = 8
                        PMPasoValores sqlconn&, "@i_val_minimo", 0, SQLMONEY, grdServicios(0).Text
                        grdServicios(0).Col = 9
                        PMPasoValores sqlconn&, "@i_val_maximo", 0, SQLMONEY, grdServicios(0).Text
                          
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_especiales", True, " Ok...Mantenimiento de Costos Especiales") Then
                            PMChequea sqlconn&
                        Else
                            MsgBox "Error al " + VTMsg$ + " los Costos Generales", 0 + 16, "Mensaje de Error"
                        End If
                    End If
                Next i%
                mskFecha_LostFocus 'Actualizar la consulta
            End If
            
            If VTPerson$ = "P" Then
                For i% = 1 To grdServicios(1).Rows - 1
                    grdServicios(1).Col = 0
                    grdServicios(1).Row = i%
                    If grdServicios(1).Text = "X" Then
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4092"
                        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
                        PMPasoValores sqlconn&, "@i_person", 0, SQLCHAR, VTPerson$
                        grdServicios(1).Col = 16
                        PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, grdServicios(1).Text
                          
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_especiales", True, " Ok...Mantenimiento de Costos Especiales") Then
                            PMChequea sqlconn&
                        Else
                            MsgBox "Error al " + VTMsg$ + " los Costos Personalizados", 0 + 16, "Mensaje de Error"
                        End If
                    End If
                Next i%
                cmdBoton_Click (3) 'Actualizar la consulta
            End If
            
            
            
        End If
End Sub


Private Sub cmbPerso_Click()
Dim i%
Dim Index%
    For i% = 1 To grdServicios(0).Rows - 1
        grdServicios(Index%).Col = 0
        grdServicios(Index%).Row = i%
        grdServicios(Index%).Text = Str$(grdServicios(Index%).Row)
        grdServicios(Index%).Picture = picVisto(1)
    Next i%
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
    
Select Case cmbPerso.Text
        Case "CTA CORRIENTE", "CTA AHORROS"
            lblEtiqueta(2).Visible = True
            lblDescripcion(0).Visible = True
            lblEtiqueta(2).Caption = "Nro. Cuenta:"
            mskCuenta.Visible = True
            txtCampo(1).Visible = False
            txtCampo(2).Visible = False
            txtCampo(1).Text = ""
            txtCampo(2).Text = ""
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            mskCuenta_GotFocus
            lblDescripcion(0).Caption = ""
            'mskFecha.Text = VLFecha$
            If mskCuenta.Visible = True Then mskCuenta.SetFocus
        
        Case "CLIENTE"
            lblEtiqueta(2).Visible = True
            lblDescripcion(0).Visible = True
            lblEtiqueta(2).Caption = "Código Cliente:"
            mskCuenta.Visible = False
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(1).Text = ""
            txtCampo(1).Visible = False
            txtCampo(2).Text = ""
            txtCampo(2).Visible = True
            'mskFecha.Text = VLFecha$
            txtCampo(2).SetFocus
    
        Case "OFICINA"
            lblEtiqueta(2).Visible = True
            lblDescripcion(0).Visible = True
            lblEtiqueta(2).Caption = "Código Oficina:"
            mskCuenta.Visible = False
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(1).Text = ""
            txtCampo(1).Visible = True
            txtCampo(2).Text = ""
            txtCampo(2).Visible = False
            'mskFecha.Text = VLFecha$
            txtCampo(1).SetFocus
            
End Select
End Sub

Private Sub cmbperso_GotFocus()
 FPrincipal.pnlHelpLine.Caption = " Tipo de Personalización Especial"
End Sub

Private Sub cmdBoton_Click(Index As Integer)
Dim i%
   Select Case Index%
    Case 0 'Aprobar
        VLAProbar = "S"
        PLTransmitir
        
    Case 5 'Eliminar
        VLAProbar = "N"
        PLTransmitir
        
    Case 1 'Limpiar
        cmbPerso.Clear
        cmbPerso.AddItem "CTA CORRIENTE", 0
        cmbPerso.AddItem "CTA AHORROS", 1
        cmbPerso.AddItem "CLIENTE", 2
        cmbPerso.AddItem "OFICINA", 3
        cmbPerso.ListIndex = 0
    
        mskCuenta.Mask = ""
        mskCuenta.Text = ""
        mskCuenta_GotFocus
        For i% = 0 To 3
            lblDescripcion(i%).Caption = ""
        Next i%
        mskFecha.Text = Format$(VLFecha$, VLFormatoFecha$)
        
        For i% = 0 To 2
            txtCampo(i%).Text = ""
        Next i%
        
        For i% = 0 To 1
            grdServicios(i%).Rows = 2
            grdServicios(i%).Cols = 2
            grdServicios(i%).Row = 0
            grdServicios(i%).Col = 1
            grdServicios(i%).Text = ""
            grdServicios(i%).Row = 1
            grdServicios(i%).Col = 0
            grdServicios(i%).Text = ""
            grdServicios(i%).Row = 1
            grdServicios(i%).Col = 1
            grdServicios(i%).Text = ""
            grdServicios(i%).ColWidth(1) = grdServicios(i%).ColWidth(0)
        Next i%
        
        cmdBoton(0).Enabled = True
        txtCampo(0).SetFocus
        
    Case 2 'Salir
        
        Unload FManteEspecial
        Unload FBuscarCliente
        'Unload FBuscarLabor
        
    Case 3 'Buscar costos especiales personalizados
        
        If txtCampo(0).Text = "" Then
            MsgBox "El servicio disponible es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        If mskFecha.ClipText = "" Then
            MsgBox "La fecha de vigencia es obligatoria", 0 + 16, "Mensaje de Error"
            mskFecha.SetFocus
            Exit Sub
        End If
        
        If mskCuenta.ClipText = "" And (cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS") Then
            MsgBox "El Nùmero de cuenta es obligatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
            
        If txtCampo(1).Text = "" And cmbPerso.Text = "OFICINA" Then
            MsgBox "El Código de la oficina es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
            
        If txtCampo(2).Text = "" And cmbPerso.Text = "CLIENTE" Then
            MsgBox "El Código del cliente es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
            
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4091"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha((mskFecha.Text), Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy")
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(3).Caption
         PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, txtCampo(2).Text
        
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_especiales", True, "Ok... Consulta de Costos Especiales Personalizados") Then
             PMMapeaGrid sqlconn&, grdServicios(1), False
             PMChequea sqlconn&
             grdServicios(1).Col = 0
             grdServicios(1).Row = 1
             grdServicios(1).Picture = picVisto(1)
         End If
                 
         grdServicios(1).ColWidth(1) = 1300
         grdServicios(1).ColWidth(8) = 1800
         grdServicios(1).ColWidth(6) = 1500
         grdServicios(1).ColWidth(7) = 1500
         For i% = 12 To 18
         grdServicios(1).ColWidth(i%) = 1
         Next i%
         
    Case 4 'Imprimir
        PLImprimir
        
End Select


End Sub
Private Sub PLImprimir()
Dim VTPrint$
Dim j%, i%
    VTPrint$ = "N"
    grdServicios(0).Row = 1
    grdServicios(0).Col = 1
    If grdServicios(0).Text <> "" Then
        VTPrint$ = "S"
        Screen.MousePointer = 11 'Reloj de Espera
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontName = "Courier New"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontBold = True
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.CurrentX = 0
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.CurrentY = 0
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontSize = 14
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "                             " + VGBanco$
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "             REPORTE DE COSTOS ESPECIALES PERSONALIZADOS"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontSize = 12
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "   FECHA IMPRESION: " + VGFecha$
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "   COSTOS GENERALES"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontSize = 7
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "   ______________________________________________________________________________________________________________________________"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "     F. Vigencia   Estado     Descripción                               Tipo  Desde           Hasta                Valor Costo"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "   ______________________________________________________________________________________________________________________________"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontBold = False
        
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Y = Printer.CurrentY
        For j% = 1 To grdServicios(0).Rows - 1
            Y = Y + 150
            grdServicios(0).Row = j%
            grdServicios(0).Col = 1
            For i% = 1 To grdServicios(0).Cols - 1
                Select Case i%
                Case 1 'fecha
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 400
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                Case 2 'estado
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 1600
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                Case 11 'descripcion
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 2500
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                Case 10 'tipo
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 6200
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                Case 5 'desde
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 6500
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                Case 6 'hasta
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 8000
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                Case 7 'valor
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 9700
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                End Select
                Select Case i%
                    Case 1, 2, 5, 6, 7, 10, 11
                        grdServicios(0).Col = i%
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                        Printer.Print grdServicios(0).Text
                End Select
            Next i%
        Next j%
    End If
    
    grdServicios(1).Row = 1
    grdServicios(1).Col = 1
    If grdServicios(1).Text <> "" Then
        VTPrint$ = "S"
        Screen.MousePointer = 11 'Reloj de Espera
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontName = "Courier New"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontSize = 12
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontBold = True
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "   COSTOS PERSONALIZADOS"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
        If mskCuenta.ClipText <> "" Then
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
            Printer.Print "    Cuenta: " + mskCuenta.Text + " " + lblDescripcion(0).Caption
        End If
        If txtCampo(1).Text <> "" Then
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
            Printer.Print "    Oficina: " + txtCampo(1).Text + " " + lblDescripcion(0).Caption
        End If
        If txtCampo(2).Text <> "" Then
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
            Printer.Print "    Cliente: " + txtCampo(2).Text + " " + lblDescripcion(0).Caption
        End If
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontSize = 7
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print ""
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "   ______________________________________________________________________________________________________________________________"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "     F. Vigencia   Tipo Costo       Descripción                 Tipo    Desde            Hasta                  Valor Costo"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.Print "   ______________________________________________________________________________________________________________________________"
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.FontBold = False
        
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Y = Printer.CurrentY
        For j% = 1 To grdServicios(1).Rows - 1
            Y = Y + 150
            grdServicios(1).Row = j%
            grdServicios(1).Col = 1
            For i% = 1 To grdServicios(1).Cols - 1
                Select Case i%
                Case 1 'fecha
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 400
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                Case 2 'tipo costo
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 1600
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                Case 4 'descripcion
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 3000
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                Case 5 'tipo
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                      Printer.CurrentX = 5500
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                      Printer.CurrentY = Y
                Case 6 'desde
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                      Printer.CurrentX = 6000
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                      Printer.CurrentY = Y
                Case 7 'hasta
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                      Printer.CurrentX = 7500
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                      Printer.CurrentY = Y
                Case 8 'valor
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentX = 9500
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.CurrentY = Y
                End Select
                Select Case i%
                Case 1, 2, 4, 5, 6, 7, 8
                    grdServicios(1).Col = i%
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
                    Printer.Print grdServicios(1).Text
                End Select
            Next i%
        Next j%
                    
    End If
    
    If VTPrint$ = "S" Then
'FIXIT: Printer object and Printers collection not upgraded to Visual Basic .NET by the Upgrade Wizard.     FixIT90210ae-R5481-H1984
        Printer.EndDoc
        Screen.MousePointer = 0 'Cursor normal
        Screen.MousePointer = 0
    End If
End Sub


Private Sub Form_Load()
    FManteEspecial.Left = 15
    FManteEspecial.Top = 15
    FManteEspecial.Width = 9420
    FManteEspecial.Height = 5730
    PMBotonSeguridad FManteEspecial, 3
    cmbPerso.Clear
    cmbPerso.AddItem "CTA CORRIENTE", 0
    cmbPerso.AddItem "CTA AHORROS", 1
    cmbPerso.AddItem "CLIENTE", 2
    cmbPerso.AddItem "OFICINA", 3
    cmbPerso.ListIndex = 0
    
    VLTipo_dato$ = ""
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskFecha.Mask = FMMascaraFecha(VLFormatoFecha$)
    VLFecha$ = FMConvFecha((VGFecha), "mm/dd/yyyy", Get_Preferencia("FORMATO-FECHA"))
    mskFecha.Text = VLFecha$
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub


Private Sub PMMarcarRegistro(Index As Integer)
    
    grdServicios(Index%).Col = 0
    If grdServicios(Index%).Text <> "X" Then
        grdServicios(Index%).Text = "X"
        grdServicios(Index%).Picture = picVisto(0)
    Else
        If grdServicios(Index%).Text = "X" Then
            grdServicios(Index%).Text = Str$(grdServicios(Index%).Row)
            grdServicios(Index%).Picture = picVisto(1)
        End If
    End If
    
End Sub

Private Sub grdServicios_DblClick(Index As Integer)
Dim VTRow%
    VTRow% = grdServicios(Index%).Row
    grdServicios(Index%).Row = 1
    grdServicios(Index%).Col = 1
    If grdServicios(Index%).Text <> "" Then
            grdServicios(Index%).Row = VTRow%
            Select Case Index%
            Case 0, 1
                If Val(grdServicios(Index%).Tag) > 0 Then
                  cmdBoton(0).Enabled = True
                  PMMarcarRegistro Index%
                  
                End If
            End Select
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

Private Sub mskCuenta_GotFocus()
    If cmbPerso.Text <> "" Then

        If cmbPerso.Text = "CTA CORRIENTE" Then
            mskCuenta.Mask = VGMascaraCtaCte$
            FPrincipal.pnlHelpLine.Caption = " Número de la Cuenta Corriente"
        Else
            mskCuenta.Mask = VGMascaraCtaAho$
            FPrincipal.pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
        End If
    End If
    
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)

End Sub

Private Sub mskCuenta_LostFocus()
Dim VLTipo%
Dim VTR1%
    On Error Resume Next
    If cmbPerso.Text <> "CTA CORRIENTE" And cmbPerso.Text <> "CTA AHORROS" Then
        MsgBox "El tipo de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
        cmbPerso.SetFocus
        Exit Sub
    End If
    If mskCuenta.ClipText <> "" Then
        If cmbPerso.Text = "CTA CORRIENTE" Then
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                VLTipo% = True
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4074"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                     PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
                     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_valor_contratado", True, "") Then
                        ReDim VTArreglo(10) As String
                         VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        If VTR1% <> 0 Then
                            lblDescripcion(0).Caption = VTArreglo(1)
                        Else
                            MsgBox "Error en consulta de Cuenta", 0 + 16, "Mensaje del Servidor"
                        End If
                    Else
                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                        mskCuenta.SetFocus
                    End If
                
            Else
                MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
                lblDescripcion(0).Caption = ""
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
            
        Else
            'OJO
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                VLTipo% = False
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4074"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                     PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
                     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_valor_contratado", True, "") Then
                        ReDim VTArreglo(10) As String
                         VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        If VTR1% <> 0 Then
                            lblDescripcion(0).Caption = VTArreglo(1)
                        Else
                            MsgBox "Error en consulta de Cuenta", 0 + 16, "Mensaje del Servidor"
                        End If
                    Else
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                        mskCuenta.SetFocus
                    End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                lblDescripcion(0).Caption = ""
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
        End If
End If

End Sub

Private Sub mskFecha_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Fecha de Vigencia"
    mskFecha.SelStart = 0
    mskFecha.SelLength = Len(mskFecha.Text)
End Sub

Private Sub mskFecha_LostFocus()
Dim VTValido%

 If mskFecha.ClipText <> "" Then
        VTValido% = FMVerFormato((mskFecha.FormattedText), VGFormatoFecha$)
        If Not VTValido% Then
            MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
            mskFecha.Mask = ""
            mskFecha.Text = ""
            mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
            mskFecha.SetFocus
            Exit Sub
        End If
        PMBuscarServicio 'buscar costos generales
    End If

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        VLPaso% = True
        FPrincipal.pnlHelpLine.Caption = " Código del Servicio Disponible [F5 Ayuda]"
    Case 1
        VLPaso% = True
        FPrincipal.pnlHelpLine.Caption = " Código de la Oficina [F5 Ayuda]"
    Case 2
        VLPaso% = True
        FPrincipal.pnlHelpLine.Caption = " Código del Cliente [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Rubro del Servicio [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub
Private Sub txtCampo_Change(Index As Integer)
'    If Index% = 1 Or Index% = 2 Then
        VLPaso% = False
'    End If
End Sub
Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode = VGTeclaAyuda% Then
      Select Case Index%
        Case 0 'Serv disponible
            VGForma$ = "FManteEspecial"
            FAyudaSubserv2.Show 1
            'Unload FRubros
            If VGDetalle(1) <> "" Then
                PMSubserv
                VLPaso% = True
            End If
        
        Case 1 'Oficina
            VGOperacion$ = "sp_oficina"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(0).Text & "]") Then
                PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(1).Text = VGACatalogo.Codigo$
                lblDescripcion(0).Caption = VGACatalogo.Descripcion$
            End If
            VLPaso% = True
        
        Case 2 'clientes
            FBuscarCliente.optCliente(0).Value = True
            FBuscarCliente.Show 1
            FBuscarCliente.optCliente(1).Enabled = True
            If VGBusqueda(1) <> "" Then
                txtCampo(2).Text = VGBusqueda(1)
                lblDescripcion(0).Caption = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
            End If
            VLPaso% = True
        
        Case 3 'rubro
            PMCatalogo "A", "pe_rubro", txtCampo(3), lblDescripcion(2)
            'txtCampo(3).SetFocus
            VLPaso% = True
      End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
    If VLPaso% = False Then
      Select Case Index%
        Case 0  'ser disponible
                If VLPaso% = False Then
                    If txtCampo(0).Text <> "" Then
                       VGForma$ = "FManteEspecial"
                       FAyudaSubserv2.Show 1
                       If VGDetalle(1) <> "" Then
                            PMSubserv
                       Else
                            If lblDescripcion(2).Caption = "" Then
                                txtCampo(0).Text = ""
                                txtCampo(0).SetFocus
                                VLPaso% = True
                            End If
                       End If
                    Else
                       VLPaso% = True
                       lblDescripcion(1).Caption = ""
                       lblDescripcion(2).Caption = ""
                       lblDescripcion(3).Caption = ""
                    End If
                End If
                
        Case 1 'oficina
            If txtCampo(1).Text <> "" Then
                PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(0).Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                Else
                    VLPaso% = True
                    txtCampo(2).Text = ""
                    lblDescripcion(0).Caption = ""
                    'txtCampo(1).SetFocus
                    'PMLimpiaGrid grdServicios
                End If
            Else
                'txtCampo(1).SetFocus
                lblDescripcion(0).Caption = ""
            End If
            
        Case 2 'cliente
            If txtCampo(2).Text <> "" Then
                ReDim VTArreglo(7) As String
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1190"
                PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (txtCampo(2).Text)
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_qrente", False, "") Then
                     VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                     PMChequea sqlconn&
                     lblDescripcion(0).Caption = VTArreglo(1)
                Else
                    txtCampo(2).Text = ""
                    lblDescripcion(0).Caption = ""
                End If
            End If
        
        Case 3 'Rubro
            If VLPaso% = False Then
                If txtCampo(3).Text <> "" Then
                    PMCatalogo "V", "pe_rubro", txtCampo(3), lblDescripcion(2)
                Else
                    lblDescripcion(2).Caption = ""
                End If
            End If
      End Select
    End If
End Sub


Private Sub PMSubserv()
    If VGDetalle(0) = "S" Then
        If txtCampo(0).Text = "" Then

            lblDescripcion(1).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(2).Caption = VGDetalle(2) 'des rubro
            txtCampo(0).Text = VGDetalle(3) 'cod serv dis
            lblDescripcion(3).Caption = VGDetalle(4) 'cod rubro
            
        Else
            lblDescripcion(1).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(2).Caption = VGDetalle(2) 'des rubro
            lblDescripcion(3).Caption = VGDetalle(3) 'cod rubro

        End If
        PMBuscarServicio 'buscar costos generales
    End If
End Sub
Sub PMBuscarServicio()
Dim i%
        grdServicios(0).Col = 0
        grdServicios(0).Row = 1
        grdServicios(0).Picture = picVisto(1)
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4091"
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, lblDescripcion(3).Caption
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
        PMPasoValores sqlconn&, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha((mskFecha.Text), Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy")
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_especiales", True, "Ok... Consulta de Detalle de Servicios Especiales") Then
            PMMapeaGrid sqlconn&, grdServicios(0), False
            PMChequea sqlconn&
        End If
        grdServicios(0).Row = 1
        grdServicios(0).ColWidth(1) = 1300
        grdServicios(0).ColWidth(11) = 3500
        grdServicios(0).ColWidth(5) = 1500
        grdServicios(0).ColWidth(6) = 1500
        For i% = 13 To 16
            grdServicios(0).ColWidth(i%) = 1
        Next i%
End Sub


