Imports COBISCorp.tCOBIS.TADMIN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class Ftran220Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        InitializeoptTarjetaDebito()
        InitializelblEtiqueta()
        InitializelblDescripcion()
        InitializecmdBoton()
        'This form is an MDI child.
        'This code simulates the Compatibility.VB6 
        ' functionality of automatically
        ' loading and showing an MDI
        ' child's parent.


        'The MDI form in the Compatibility.VB6 project had its
        'AutoShowChildren property set to True
        'To simulate the Compatibility.VB6 behavior, we need to
        'automatically Show the form whenever it
        'is loaded.  If you do not want this behavior
        'then delete the following line of code
        'UPGRADE_TODO: (2018) Remove the next line of code to stop form from automatically showing. More Information: http://www.vbtonet.com/ewis/ewi2018.aspx
    End Sub
    Private Sub ReleaseResources(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Closed
        Dispose(True)
    End Sub
    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
        If Disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(Disposing)
    End Sub
    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Private WithEvents _optTarjetaDebito_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optTarjetaDebito_1 As System.Windows.Forms.RadioButton
    Public WithEvents FrmTarjetaDeb As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _lblEtiqueta_52 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_51 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_50 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_49 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_48 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_47 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_45 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_46 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_47 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_48 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_49 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_44 As System.Windows.Forms.Label
    Public WithEvents frmhistdeb As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_7 As System.Windows.Forms.Button
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _lblEtiqueta_46 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_45 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_44 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_43 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_42 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_41 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_50 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_51 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_52 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_53 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_54 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_55 As System.Windows.Forms.Label
    Public WithEvents frmhistcre As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Public WithEvents LblTarjetaDeb As System.Windows.Forms.Label
    Public WithEvents lbldesalianza As System.Windows.Forms.Label
    Public WithEvents Lblalianza As System.Windows.Forms.Label
    Public WithEvents Label5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_61 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_57 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_60 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_71 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_35 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_37 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_59 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_56 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_55 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_58 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_57 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_54 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_56 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_43 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_40 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_42 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_39 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_41 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_36 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_39 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_38 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_35 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_37 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_36 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_53 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_33 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_14 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_22 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_32 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_26 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_33 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_29 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_34 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_30 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_38 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_20 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_31 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_40 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_19 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_12 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_25 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_11 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_28 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_27 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_29 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_24 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_22 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_23 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_30 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_18 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_28 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_17 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_27 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_16 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_26 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_15 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_25 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_14 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_24 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_13 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_23 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_9 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_11 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_20 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_19 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_18 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_17 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_16 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_15 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_21 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_31 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_32 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_34 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_13 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_21 As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
    Public cmdBoton(7) As System.Windows.Forms.Button
    Public lblDescripcion(61) As System.Windows.Forms.Label
    Public lblEtiqueta(71) As System.Windows.Forms.Label
    Public optTarjetaDebito(1) As System.Windows.Forms.RadioButton
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Ftran220Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.FrmTarjetaDeb = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optTarjetaDebito_0 = New System.Windows.Forms.RadioButton()
        Me._optTarjetaDebito_1 = New System.Windows.Forms.RadioButton()
        Me.frmhistdeb = New Infragistics.Win.Misc.UltraGroupBox()
        Me._lblEtiqueta_52 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_51 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_50 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_49 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_48 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_47 = New System.Windows.Forms.Label()
        Me._lblDescripcion_45 = New System.Windows.Forms.Label()
        Me._lblDescripcion_46 = New System.Windows.Forms.Label()
        Me._lblDescripcion_47 = New System.Windows.Forms.Label()
        Me._lblDescripcion_48 = New System.Windows.Forms.Label()
        Me._lblDescripcion_49 = New System.Windows.Forms.Label()
        Me._lblDescripcion_44 = New System.Windows.Forms.Label()
        Me.frmhistcre = New Infragistics.Win.Misc.UltraGroupBox()
        Me._lblEtiqueta_46 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_45 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_44 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_43 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_42 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_41 = New System.Windows.Forms.Label()
        Me._lblDescripcion_50 = New System.Windows.Forms.Label()
        Me._lblDescripcion_51 = New System.Windows.Forms.Label()
        Me._lblDescripcion_52 = New System.Windows.Forms.Label()
        Me._lblDescripcion_53 = New System.Windows.Forms.Label()
        Me._lblDescripcion_54 = New System.Windows.Forms.Label()
        Me._lblDescripcion_55 = New System.Windows.Forms.Label()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me.LblTarjetaDeb = New System.Windows.Forms.Label()
        Me.lbldesalianza = New System.Windows.Forms.Label()
        Me.Lblalianza = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_61 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_57 = New System.Windows.Forms.Label()
        Me._lblDescripcion_60 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_71 = New System.Windows.Forms.Label()
        Me._lblDescripcion_35 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_37 = New System.Windows.Forms.Label()
        Me._lblDescripcion_59 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_56 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_55 = New System.Windows.Forms.Label()
        Me._lblDescripcion_58 = New System.Windows.Forms.Label()
        Me._lblDescripcion_57 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_54 = New System.Windows.Forms.Label()
        Me._lblDescripcion_56 = New System.Windows.Forms.Label()
        Me._lblDescripcion_43 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_40 = New System.Windows.Forms.Label()
        Me._lblDescripcion_42 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_39 = New System.Windows.Forms.Label()
        Me._lblDescripcion_41 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_36 = New System.Windows.Forms.Label()
        Me._lblDescripcion_39 = New System.Windows.Forms.Label()
        Me._lblDescripcion_38 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_35 = New System.Windows.Forms.Label()
        Me._lblDescripcion_37 = New System.Windows.Forms.Label()
        Me._lblDescripcion_36 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_53 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_33 = New System.Windows.Forms.Label()
        Me._lblDescripcion_14 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_22 = New System.Windows.Forms.Label()
        Me._lblDescripcion_32 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_26 = New System.Windows.Forms.Label()
        Me._lblDescripcion_33 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_29 = New System.Windows.Forms.Label()
        Me._lblDescripcion_34 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_30 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_38 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_20 = New System.Windows.Forms.Label()
        Me._lblDescripcion_31 = New System.Windows.Forms.Label()
        Me._lblDescripcion_40 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_19 = New System.Windows.Forms.Label()
        Me._lblDescripcion_12 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_25 = New System.Windows.Forms.Label()
        Me._lblDescripcion_11 = New System.Windows.Forms.Label()
        Me._lblDescripcion_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_28 = New System.Windows.Forms.Label()
        Me._lblDescripcion_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_27 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_29 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_24 = New System.Windows.Forms.Label()
        Me._lblDescripcion_22 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_23 = New System.Windows.Forms.Label()
        Me._lblDescripcion_30 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_18 = New System.Windows.Forms.Label()
        Me._lblDescripcion_28 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_17 = New System.Windows.Forms.Label()
        Me._lblDescripcion_27 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_16 = New System.Windows.Forms.Label()
        Me._lblDescripcion_26 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_15 = New System.Windows.Forms.Label()
        Me._lblDescripcion_25 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_14 = New System.Windows.Forms.Label()
        Me._lblDescripcion_24 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_13 = New System.Windows.Forms.Label()
        Me._lblDescripcion_23 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_12 = New System.Windows.Forms.Label()
        Me._lblDescripcion_9 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_11 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_20 = New System.Windows.Forms.Label()
        Me._lblDescripcion_19 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_18 = New System.Windows.Forms.Label()
        Me._lblDescripcion_17 = New System.Windows.Forms.Label()
        Me._lblDescripcion_16 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_15 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_21 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_31 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_32 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_34 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_13 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_21 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox5 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.frmhistcredeb = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox4 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBFirmas = New System.Windows.Forms.ToolStripButton()
        Me.TSBImprimir = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBExcel = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me._cmdBoton_7 = New System.Windows.Forms.Button()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.FrmTarjetaDeb, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FrmTarjetaDeb.SuspendLayout()
        CType(Me.frmhistdeb, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmhistdeb.SuspendLayout()
        CType(Me.frmhistcre, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmhistcre.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox5, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox5.SuspendLayout()
        CType(Me.UltraGroupBox3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox3.SuspendLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox2.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        CType(Me.frmhistcredeb, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmhistcredeb.SuspendLayout()
        CType(Me.UltraGroupBox4, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox4.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        'FrmTarjetaDeb
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FrmTarjetaDeb, False)
        Me.COBISViewResizer.SetAutoResize(Me.FrmTarjetaDeb, False)
        Me.FrmTarjetaDeb.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.FrmTarjetaDeb.Controls.Add(Me._optTarjetaDebito_0)
        Me.FrmTarjetaDeb.Controls.Add(Me._optTarjetaDebito_1)
        Me.COBISStyleProvider.SetControlStyle(Me.FrmTarjetaDeb, "Default")
        Me.FrmTarjetaDeb.ForeColor = System.Drawing.Color.Navy
        Me.FrmTarjetaDeb.Location = New System.Drawing.Point(145, 102)
        Me.FrmTarjetaDeb.Name = "FrmTarjetaDeb"
        Me.FrmTarjetaDeb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrmTarjetaDeb.Size = New System.Drawing.Size(116, 33)
        Me.FrmTarjetaDeb.TabIndex = 130
        Me.FrmTarjetaDeb.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FrmTarjetaDeb, "")
        '
        '_optTarjetaDebito_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTarjetaDebito_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTarjetaDebito_0, False)
        Me._optTarjetaDebito_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTarjetaDebito_0, "Default")
        Me._optTarjetaDebito_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTarjetaDebito_0.Enabled = False
        Me._optTarjetaDebito_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._optTarjetaDebito_0.Location = New System.Drawing.Point(13, 9)
        Me._optTarjetaDebito_0.Name = "_optTarjetaDebito_0"
        Me.COBISResourceProvider.SetResourceID(Me._optTarjetaDebito_0, "5118")
        Me._optTarjetaDebito_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTarjetaDebito_0.Size = New System.Drawing.Size(41, 17)
        Me._optTarjetaDebito_0.TabIndex = 12
        Me._optTarjetaDebito_0.TabStop = True
        Me._optTarjetaDebito_0.Text = "*Si"
        Me._optTarjetaDebito_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTarjetaDebito_0, "")
        '
        '_optTarjetaDebito_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTarjetaDebito_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTarjetaDebito_1, False)
        Me._optTarjetaDebito_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTarjetaDebito_1, "Default")
        Me._optTarjetaDebito_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTarjetaDebito_1.Enabled = False
        Me._optTarjetaDebito_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._optTarjetaDebito_1.Location = New System.Drawing.Point(60, 10)
        Me._optTarjetaDebito_1.Name = "_optTarjetaDebito_1"
        Me.COBISResourceProvider.SetResourceID(Me._optTarjetaDebito_1, "5119")
        Me._optTarjetaDebito_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTarjetaDebito_1.Size = New System.Drawing.Size(45, 17)
        Me._optTarjetaDebito_1.TabIndex = 13
        Me._optTarjetaDebito_1.TabStop = True
        Me._optTarjetaDebito_1.Text = "*No"
        Me._optTarjetaDebito_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTarjetaDebito_1, "")
        '
        'frmhistdeb
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmhistdeb, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmhistdeb, False)
        Me.frmhistdeb.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmhistdeb.Controls.Add(Me._lblEtiqueta_52)
        Me.frmhistdeb.Controls.Add(Me._lblEtiqueta_51)
        Me.frmhistdeb.Controls.Add(Me._lblEtiqueta_50)
        Me.frmhistdeb.Controls.Add(Me._lblEtiqueta_49)
        Me.frmhistdeb.Controls.Add(Me._lblEtiqueta_48)
        Me.frmhistdeb.Controls.Add(Me._lblEtiqueta_47)
        Me.frmhistdeb.Controls.Add(Me._lblDescripcion_45)
        Me.frmhistdeb.Controls.Add(Me._lblDescripcion_46)
        Me.frmhistdeb.Controls.Add(Me._lblDescripcion_47)
        Me.frmhistdeb.Controls.Add(Me._lblDescripcion_48)
        Me.frmhistdeb.Controls.Add(Me._lblDescripcion_49)
        Me.frmhistdeb.Controls.Add(Me._lblDescripcion_44)
        Me.COBISStyleProvider.SetControlStyle(Me.frmhistdeb, "Default")
        Me.frmhistdeb.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmhistdeb.ForeColor = System.Drawing.Color.Red
        Me.frmhistdeb.Location = New System.Drawing.Point(5, 8)
        Me.frmhistdeb.Name = "frmhistdeb"
        Me.COBISResourceProvider.SetResourceID(Me.frmhistdeb, "500738")
        Me.frmhistdeb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmhistdeb.Size = New System.Drawing.Size(160, 161)
        Me.frmhistdeb.TabIndex = 92
        Me.frmhistdeb.Text = "*HISTORICO DE DEBITOS"
        Me.frmhistdeb.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.frmhistdeb.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmhistdeb, "")
        '
        '_lblEtiqueta_52
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_52, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_52, False)
        Me._lblEtiqueta_52.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_52, "Default")
        Me._lblEtiqueta_52.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_52.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_52.Location = New System.Drawing.Point(6, 133)
        Me._lblEtiqueta_52.Name = "_lblEtiqueta_52"
        Me._lblEtiqueta_52.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_52.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_52.TabIndex = 117
        Me._lblEtiqueta_52.Text = "6."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_52, "")
        '
        '_lblEtiqueta_51
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_51, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_51, False)
        Me._lblEtiqueta_51.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_51, "Default")
        Me._lblEtiqueta_51.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_51.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_51.Location = New System.Drawing.Point(6, 110)
        Me._lblEtiqueta_51.Name = "_lblEtiqueta_51"
        Me._lblEtiqueta_51.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_51.Size = New System.Drawing.Size(14, 20)
        Me._lblEtiqueta_51.TabIndex = 116
        Me._lblEtiqueta_51.Text = "5."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_51, "")
        '
        '_lblEtiqueta_50
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_50, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_50, False)
        Me._lblEtiqueta_50.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_50, "Default")
        Me._lblEtiqueta_50.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_50.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_50.Location = New System.Drawing.Point(6, 87)
        Me._lblEtiqueta_50.Name = "_lblEtiqueta_50"
        Me._lblEtiqueta_50.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_50.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_50.TabIndex = 115
        Me._lblEtiqueta_50.Text = "4."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_50, "")
        '
        '_lblEtiqueta_49
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_49, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_49, False)
        Me._lblEtiqueta_49.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_49, "Default")
        Me._lblEtiqueta_49.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_49.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_49.Location = New System.Drawing.Point(6, 64)
        Me._lblEtiqueta_49.Name = "_lblEtiqueta_49"
        Me._lblEtiqueta_49.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_49.Size = New System.Drawing.Size(12, 12)
        Me._lblEtiqueta_49.TabIndex = 114
        Me._lblEtiqueta_49.Text = "3."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_49, "")
        '
        '_lblEtiqueta_48
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_48, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_48, False)
        Me._lblEtiqueta_48.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_48, "Default")
        Me._lblEtiqueta_48.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_48.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_48.Location = New System.Drawing.Point(6, 41)
        Me._lblEtiqueta_48.Name = "_lblEtiqueta_48"
        Me._lblEtiqueta_48.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_48.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_48.TabIndex = 113
        Me._lblEtiqueta_48.Text = "2."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_48, "")
        '
        '_lblEtiqueta_47
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_47, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_47, False)
        Me._lblEtiqueta_47.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_47, "Default")
        Me._lblEtiqueta_47.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_47.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_47.Location = New System.Drawing.Point(6, 18)
        Me._lblEtiqueta_47.Name = "_lblEtiqueta_47"
        Me._lblEtiqueta_47.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_47.Size = New System.Drawing.Size(8, 20)
        Me._lblEtiqueta_47.TabIndex = 112
        Me._lblEtiqueta_47.Text = "1."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_47, "")
        '
        '_lblDescripcion_45
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_45, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_45, False)
        Me._lblDescripcion_45.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_45.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_45, "Default")
        Me._lblDescripcion_45.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_45.Location = New System.Drawing.Point(22, 41)
        Me._lblDescripcion_45.Name = "_lblDescripcion_45"
        Me._lblDescripcion_45.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_45.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_45.TabIndex = 34
        Me._lblDescripcion_45.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_45, "")
        '
        '_lblDescripcion_46
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_46, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_46, False)
        Me._lblDescripcion_46.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_46.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_46, "Default")
        Me._lblDescripcion_46.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_46.Location = New System.Drawing.Point(22, 64)
        Me._lblDescripcion_46.Name = "_lblDescripcion_46"
        Me._lblDescripcion_46.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_46.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_46.TabIndex = 35
        Me._lblDescripcion_46.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_46, "")
        '
        '_lblDescripcion_47
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_47, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_47, False)
        Me._lblDescripcion_47.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_47.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_47, "Default")
        Me._lblDescripcion_47.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_47.Location = New System.Drawing.Point(22, 87)
        Me._lblDescripcion_47.Name = "_lblDescripcion_47"
        Me._lblDescripcion_47.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_47.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_47.TabIndex = 97
        Me._lblDescripcion_47.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_47, "")
        '
        '_lblDescripcion_48
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_48, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_48, False)
        Me._lblDescripcion_48.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_48.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_48, "Default")
        Me._lblDescripcion_48.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_48.Location = New System.Drawing.Point(22, 110)
        Me._lblDescripcion_48.Name = "_lblDescripcion_48"
        Me._lblDescripcion_48.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_48.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_48.TabIndex = 96
        Me._lblDescripcion_48.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_48, "")
        '
        '_lblDescripcion_49
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_49, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_49, False)
        Me._lblDescripcion_49.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_49.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_49, "Default")
        Me._lblDescripcion_49.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_49.Location = New System.Drawing.Point(22, 133)
        Me._lblDescripcion_49.Name = "_lblDescripcion_49"
        Me._lblDescripcion_49.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_49.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_49.TabIndex = 95
        Me._lblDescripcion_49.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_49, "")
        '
        '_lblDescripcion_44
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_44, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_44, False)
        Me._lblDescripcion_44.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_44.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_44, "Default")
        Me._lblDescripcion_44.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_44.Location = New System.Drawing.Point(22, 18)
        Me._lblDescripcion_44.Name = "_lblDescripcion_44"
        Me._lblDescripcion_44.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_44.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_44.TabIndex = 94
        Me._lblDescripcion_44.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_44, "")
        '
        'frmhistcre
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmhistcre, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmhistcre, False)
        Me.frmhistcre.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmhistcre.Controls.Add(Me._lblEtiqueta_46)
        Me.frmhistcre.Controls.Add(Me._lblEtiqueta_45)
        Me.frmhistcre.Controls.Add(Me._lblEtiqueta_44)
        Me.frmhistcre.Controls.Add(Me._lblEtiqueta_43)
        Me.frmhistcre.Controls.Add(Me._lblEtiqueta_42)
        Me.frmhistcre.Controls.Add(Me._lblEtiqueta_41)
        Me.frmhistcre.Controls.Add(Me._lblDescripcion_50)
        Me.frmhistcre.Controls.Add(Me._lblDescripcion_51)
        Me.frmhistcre.Controls.Add(Me._lblDescripcion_52)
        Me.frmhistcre.Controls.Add(Me._lblDescripcion_53)
        Me.frmhistcre.Controls.Add(Me._lblDescripcion_54)
        Me.frmhistcre.Controls.Add(Me._lblDescripcion_55)
        Me.COBISStyleProvider.SetControlStyle(Me.frmhistcre, "Default")
        Me.frmhistcre.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmhistcre.ForeColor = System.Drawing.Color.Red
        Me.frmhistcre.Location = New System.Drawing.Point(5, 8)
        Me.frmhistcre.Name = "frmhistcre"
        Me.COBISResourceProvider.SetResourceID(Me.frmhistcre, "500739")
        Me.frmhistcre.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmhistcre.Size = New System.Drawing.Size(160, 162)
        Me.frmhistcre.TabIndex = 93
        Me.frmhistcre.Text = "*HISTORICO DE CREDITOS"
        Me.frmhistcre.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.frmhistcre.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmhistcre, "")
        '
        '_lblEtiqueta_46
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_46, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_46, False)
        Me._lblEtiqueta_46.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_46, "Default")
        Me._lblEtiqueta_46.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_46.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_46.Location = New System.Drawing.Point(7, 42)
        Me._lblEtiqueta_46.Name = "_lblEtiqueta_46"
        Me._lblEtiqueta_46.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_46.Size = New System.Drawing.Size(13, 13)
        Me._lblEtiqueta_46.TabIndex = 111
        Me._lblEtiqueta_46.Text = "2."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_46, "")
        '
        '_lblEtiqueta_45
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_45, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_45, False)
        Me._lblEtiqueta_45.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_45, "Default")
        Me._lblEtiqueta_45.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_45.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_45.Location = New System.Drawing.Point(7, 65)
        Me._lblEtiqueta_45.Name = "_lblEtiqueta_45"
        Me._lblEtiqueta_45.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_45.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_45.TabIndex = 110
        Me._lblEtiqueta_45.Text = "3."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_45, "")
        '
        '_lblEtiqueta_44
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_44, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_44, False)
        Me._lblEtiqueta_44.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_44, "Default")
        Me._lblEtiqueta_44.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_44.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_44.Location = New System.Drawing.Point(7, 88)
        Me._lblEtiqueta_44.Name = "_lblEtiqueta_44"
        Me._lblEtiqueta_44.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_44.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_44.TabIndex = 109
        Me._lblEtiqueta_44.Text = "4."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_44, "")
        '
        '_lblEtiqueta_43
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_43, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_43, False)
        Me._lblEtiqueta_43.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_43, "Default")
        Me._lblEtiqueta_43.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_43.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_43.Location = New System.Drawing.Point(7, 111)
        Me._lblEtiqueta_43.Name = "_lblEtiqueta_43"
        Me._lblEtiqueta_43.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_43.Size = New System.Drawing.Size(9, 20)
        Me._lblEtiqueta_43.TabIndex = 108
        Me._lblEtiqueta_43.Text = "5."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_43, "")
        '
        '_lblEtiqueta_42
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_42, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_42, False)
        Me._lblEtiqueta_42.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_42, "Default")
        Me._lblEtiqueta_42.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_42.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_42.Location = New System.Drawing.Point(7, 134)
        Me._lblEtiqueta_42.Name = "_lblEtiqueta_42"
        Me._lblEtiqueta_42.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_42.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_42.TabIndex = 107
        Me._lblEtiqueta_42.Text = "6."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_42, "")
        '
        '_lblEtiqueta_41
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_41, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_41, False)
        Me._lblEtiqueta_41.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_41, "Default")
        Me._lblEtiqueta_41.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_41.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_41.Location = New System.Drawing.Point(7, 19)
        Me._lblEtiqueta_41.Name = "_lblEtiqueta_41"
        Me._lblEtiqueta_41.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_41.Size = New System.Drawing.Size(8, 20)
        Me._lblEtiqueta_41.TabIndex = 106
        Me._lblEtiqueta_41.Text = "1."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_41, "")
        '
        '_lblDescripcion_50
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_50, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_50, False)
        Me._lblDescripcion_50.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_50.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_50, "Default")
        Me._lblDescripcion_50.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_50.Location = New System.Drawing.Point(22, 19)
        Me._lblDescripcion_50.Name = "_lblDescripcion_50"
        Me._lblDescripcion_50.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_50.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_50.TabIndex = 33
        Me._lblDescripcion_50.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_50, "")
        '
        '_lblDescripcion_51
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_51, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_51, False)
        Me._lblDescripcion_51.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_51.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_51, "Default")
        Me._lblDescripcion_51.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_51.Location = New System.Drawing.Point(22, 42)
        Me._lblDescripcion_51.Name = "_lblDescripcion_51"
        Me._lblDescripcion_51.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_51.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_51.TabIndex = 104
        Me._lblDescripcion_51.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_51, "")
        '
        '_lblDescripcion_52
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_52, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_52, False)
        Me._lblDescripcion_52.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_52.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_52, "Default")
        Me._lblDescripcion_52.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_52.Location = New System.Drawing.Point(22, 65)
        Me._lblDescripcion_52.Name = "_lblDescripcion_52"
        Me._lblDescripcion_52.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_52.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_52.TabIndex = 103
        Me._lblDescripcion_52.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_52, "")
        '
        '_lblDescripcion_53
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_53, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_53, False)
        Me._lblDescripcion_53.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_53.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_53, "Default")
        Me._lblDescripcion_53.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_53.Location = New System.Drawing.Point(22, 88)
        Me._lblDescripcion_53.Name = "_lblDescripcion_53"
        Me._lblDescripcion_53.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_53.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_53.TabIndex = 36
        Me._lblDescripcion_53.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_53, "")
        '
        '_lblDescripcion_54
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_54, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_54, False)
        Me._lblDescripcion_54.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_54.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_54, "Default")
        Me._lblDescripcion_54.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_54.Location = New System.Drawing.Point(22, 111)
        Me._lblDescripcion_54.Name = "_lblDescripcion_54"
        Me._lblDescripcion_54.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_54.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_54.TabIndex = 37
        Me._lblDescripcion_54.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_54, "")
        '
        '_lblDescripcion_55
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_55, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_55, False)
        Me._lblDescripcion_55.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_55.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_55, "Default")
        Me._lblDescripcion_55.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_55.Location = New System.Drawing.Point(22, 134)
        Me._lblDescripcion_55.Name = "_lblDescripcion_55"
        Me._lblDescripcion_55.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_55.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_55.TabIndex = 38
        Me._lblDescripcion_55.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_55, "")
        '
        '_cmdBoton_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_4, False)
        Me._cmdBoton_4.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_4, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_4, True)
        Me._cmdBoton_4.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_4, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_4, Nothing)
        Me._cmdBoton_4.Enabled = False
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(-100, 60)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 66
        Me._cmdBoton_4.Text = "*&Firma"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        '_cmdBoton_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_3, False)
        Me._cmdBoton_3.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_3, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_3, True)
        Me._cmdBoton_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_3, Nothing)
        Me._cmdBoton_3.Enabled = False
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-100, 111)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 31
        Me._cmdBoton_3.Tag = "6335"
        Me._cmdBoton_3.Text = "*&Imprimir"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        '_cmdBoton_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_2, False)
        Me._cmdBoton_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_2, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_2, True)
        Me._cmdBoton_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_2, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_2, Nothing)
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(-100, 353)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 4
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_cmdBoton_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_1, False)
        Me._cmdBoton_1.BackColor = System.Drawing.SystemColors.Control
        Me._cmdBoton_1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_1, True)
        Me._cmdBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_1, Nothing)
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Location = New System.Drawing.Point(-700, 302)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 3
        Me._cmdBoton_1.Text = "*&Limpiar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_cmdBoton_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_0, False)
        Me._cmdBoton_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_0, True)
        Me._cmdBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_0, Nothing)
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Location = New System.Drawing.Point(-100, 200)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 2
        Me._cmdBoton_0.Text = "*&Transmitir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(156, 10)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(138, 18)
        Me.mskCuenta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_cmdBoton_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_6, False)
        Me._cmdBoton_6.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_6, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_6, True)
        Me._cmdBoton_6.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_6, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_6, Nothing)
        Me._cmdBoton_6.Enabled = False
        Me._cmdBoton_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_6.Location = New System.Drawing.Point(-100, 251)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 129
        Me._cmdBoton_6.Text = "*Siguien&te"
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
        '
        'LblTarjetaDeb
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.LblTarjetaDeb, False)
        Me.COBISViewResizer.SetAutoResize(Me.LblTarjetaDeb, False)
        Me.LblTarjetaDeb.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.LblTarjetaDeb, "Default")
        Me.LblTarjetaDeb.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblTarjetaDeb.ForeColor = System.Drawing.Color.Navy
        Me.LblTarjetaDeb.Location = New System.Drawing.Point(10, 103)
        Me.LblTarjetaDeb.Name = "LblTarjetaDeb"
        Me.COBISResourceProvider.SetResourceID(Me.LblTarjetaDeb, "2302")
        Me.LblTarjetaDeb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblTarjetaDeb.Size = New System.Drawing.Size(64, 14)
        Me.LblTarjetaDeb.TabIndex = 133
        Me.LblTarjetaDeb.Text = "*Tarj. Deb.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.LblTarjetaDeb, "")
        '
        'lbldesalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lbldesalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.lbldesalianza, False)
        Me.lbldesalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lbldesalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lbldesalianza, "Default")
        Me.lbldesalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.lbldesalianza.Location = New System.Drawing.Point(260, 559)
        Me.lbldesalianza.Name = "lbldesalianza"
        Me.lbldesalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lbldesalianza.Size = New System.Drawing.Size(370, 20)
        Me.lbldesalianza.TabIndex = 134
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lbldesalianza, "")
        '
        'Lblalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Lblalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.Lblalianza, False)
        Me.Lblalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Lblalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.Lblalianza, "Default")
        Me.Lblalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.Lblalianza.Location = New System.Drawing.Point(157, 559)
        Me.Lblalianza.Name = "Lblalianza"
        Me.Lblalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Lblalianza.Size = New System.Drawing.Size(100, 20)
        Me.Lblalianza.TabIndex = 32
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Lblalianza, "")
        '
        'Label5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label5, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label5, False)
        Me.Label5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label5, "Default")
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.ForeColor = System.Drawing.Color.Red
        Me.Label5.Location = New System.Drawing.Point(20, 559)
        Me.Label5.Name = "Label5"
        Me.COBISResourceProvider.SetResourceID(Me.Label5, "2304")
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(130, 18)
        Me.Label5.TabIndex = 136
        Me.Label5.Text = "ALIANZA COMERCIAL:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label5, "")
        '
        '_lblDescripcion_61
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_61, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_61, False)
        Me._lblDescripcion_61.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_61.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_61, "Default")
        Me._lblDescripcion_61.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_61.Location = New System.Drawing.Point(109, 126)
        Me._lblDescripcion_61.Name = "_lblDescripcion_61"
        Me._lblDescripcion_61.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_61.Size = New System.Drawing.Size(200, 20)
        Me._lblDescripcion_61.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_61, "")
        '
        '_lblEtiqueta_57
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_57, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_57, False)
        Me._lblEtiqueta_57.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_57, "Default")
        Me._lblEtiqueta_57.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_57.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_57.Location = New System.Drawing.Point(10, 126)
        Me._lblEtiqueta_57.Name = "_lblEtiqueta_57"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_57, "5233")
        Me._lblEtiqueta_57.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_57.Size = New System.Drawing.Size(86, 20)
        Me._lblEtiqueta_57.TabIndex = 127
        Me._lblEtiqueta_57.Text = "*Fideicomiso:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_57, "")
        '
        '_lblDescripcion_60
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_60, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_60, False)
        Me._lblDescripcion_60.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_60.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_60, "Default")
        Me._lblDescripcion_60.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_60.Location = New System.Drawing.Point(146, 149)
        Me._lblDescripcion_60.Name = "_lblDescripcion_60"
        Me._lblDescripcion_60.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_60.Size = New System.Drawing.Size(200, 20)
        Me._lblDescripcion_60.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_60, "")
        '
        '_lblEtiqueta_71
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_71, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_71, False)
        Me._lblEtiqueta_71.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_71, "Default")
        Me._lblEtiqueta_71.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_71.ForeColor = System.Drawing.Color.Red
        Me._lblEtiqueta_71.Location = New System.Drawing.Point(10, 149)
        Me._lblEtiqueta_71.Name = "_lblEtiqueta_71"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_71, "500886")
        Me._lblEtiqueta_71.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_71.Size = New System.Drawing.Size(133, 20)
        Me._lblEtiqueta_71.TabIndex = 125
        Me._lblEtiqueta_71.Text = "*PATENTE COMERCIAL:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_71, "")
        '
        '_lblDescripcion_35
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_35, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_35, False)
        Me._lblDescripcion_35.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_35.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_35, "Default")
        Me._lblDescripcion_35.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_35.Location = New System.Drawing.Point(146, 211)
        Me._lblDescripcion_35.Name = "_lblDescripcion_35"
        Me._lblDescripcion_35.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_35.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_35.TabIndex = 71
        Me._lblDescripcion_35.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_35, "")
        '
        '_lblEtiqueta_37
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_37, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_37, False)
        Me._lblEtiqueta_37.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_37, "Default")
        Me._lblEtiqueta_37.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_37.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_37.Location = New System.Drawing.Point(8, 215)
        Me._lblEtiqueta_37.Name = "_lblEtiqueta_37"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_37, "501882")
        Me._lblEtiqueta_37.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_37.Size = New System.Drawing.Size(72, 13)
        Me._lblEtiqueta_37.TabIndex = 70
        Me._lblEtiqueta_37.Text = "*Mes:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_37, "")
        '
        '_lblDescripcion_59
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_59, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_59, False)
        Me._lblDescripcion_59.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_59.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_59, "Default")
        Me._lblDescripcion_59.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_59.Location = New System.Drawing.Point(146, 119)
        Me._lblDescripcion_59.Name = "_lblDescripcion_59"
        Me._lblDescripcion_59.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_59.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_59.TabIndex = 18
        Me._lblDescripcion_59.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me._lblDescripcion_59.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_59, "")
        '
        '_lblEtiqueta_56
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_56, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_56, False)
        Me._lblEtiqueta_56.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_56, "Default")
        Me._lblEtiqueta_56.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_56.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_56.Location = New System.Drawing.Point(10, 119)
        Me._lblEtiqueta_56.Name = "_lblEtiqueta_56"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_56, "5217")
        Me._lblEtiqueta_56.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_56.Size = New System.Drawing.Size(98, 20)
        Me._lblEtiqueta_56.TabIndex = 123
        Me._lblEtiqueta_56.Text = "*Chq Ext. Ayer:"
        Me._lblEtiqueta_56.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_56, "")
        '
        '_lblEtiqueta_55
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_55, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_55, False)
        Me._lblEtiqueta_55.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_55, "Default")
        Me._lblEtiqueta_55.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_55.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_55.Location = New System.Drawing.Point(10, 80)
        Me._lblEtiqueta_55.Name = "_lblEtiqueta_55"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_55, "501884")
        Me._lblEtiqueta_55.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_55.Size = New System.Drawing.Size(64, 13)
        Me._lblEtiqueta_55.TabIndex = 122
        Me._lblEtiqueta_55.Text = "*T. Cuota:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_55, "")
        '
        '_lblDescripcion_58
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_58, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_58, False)
        Me._lblDescripcion_58.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_58.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_58, "Default")
        Me._lblDescripcion_58.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_58.Location = New System.Drawing.Point(145, 79)
        Me._lblDescripcion_58.Name = "_lblDescripcion_58"
        Me._lblDescripcion_58.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_58.Size = New System.Drawing.Size(116, 43)
        Me._lblDescripcion_58.TabIndex = 121
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_58, "")
        '
        '_lblDescripcion_57
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_57, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_57, False)
        Me._lblDescripcion_57.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_57.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_57, "Default")
        Me._lblDescripcion_57.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_57.Location = New System.Drawing.Point(106, 79)
        Me._lblDescripcion_57.Name = "_lblDescripcion_57"
        Me._lblDescripcion_57.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_57.Size = New System.Drawing.Size(35, 20)
        Me._lblDescripcion_57.TabIndex = 11
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_57, "")
        '
        '_lblEtiqueta_54
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_54, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_54, False)
        Me._lblEtiqueta_54.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_54, "Default")
        Me._lblEtiqueta_54.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_54.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_54.Location = New System.Drawing.Point(10, 211)
        Me._lblEtiqueta_54.Name = "_lblEtiqueta_54"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_54, "501885")
        Me._lblEtiqueta_54.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_54.Size = New System.Drawing.Size(82, 20)
        Me._lblEtiqueta_54.TabIndex = 119
        Me._lblEtiqueta_54.Text = "*Mant. Valor:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_54, "")
        '
        '_lblDescripcion_56
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_56, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_56, False)
        Me._lblDescripcion_56.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_56.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_56, "Default")
        Me._lblDescripcion_56.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_56.Location = New System.Drawing.Point(96, 211)
        Me._lblDescripcion_56.Name = "_lblDescripcion_56"
        Me._lblDescripcion_56.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_56.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_56.TabIndex = 29
        Me._lblDescripcion_56.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_56, "")
        '
        '_lblDescripcion_43
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_43, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_43, False)
        Me._lblDescripcion_43.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_43.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_43, "Default")
        Me._lblDescripcion_43.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_43.Location = New System.Drawing.Point(25, 284)
        Me._lblDescripcion_43.Name = "_lblDescripcion_43"
        Me._lblDescripcion_43.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_43.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_43.TabIndex = 42
        Me._lblDescripcion_43.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me._lblDescripcion_43.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_43, "")
        '
        '_lblEtiqueta_40
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_40, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_40, False)
        Me._lblEtiqueta_40.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_40, "Default")
        Me._lblEtiqueta_40.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_40.ForeColor = System.Drawing.Color.Red
        Me._lblEtiqueta_40.Location = New System.Drawing.Point(10, 269)
        Me._lblEtiqueta_40.Name = "_lblEtiqueta_40"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_40, "500767")
        Me._lblEtiqueta_40.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_40.Size = New System.Drawing.Size(138, 11)
        Me._lblEtiqueta_40.TabIndex = 90
        Me._lblEtiqueta_40.Text = "*MONTO BLOQUEADO:"
        Me._lblEtiqueta_40.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_40, "")
        '
        '_lblDescripcion_42
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_42, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_42, False)
        Me._lblDescripcion_42.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_42.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_42, "Default")
        Me._lblDescripcion_42.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_42.Location = New System.Drawing.Point(298, 10)
        Me._lblDescripcion_42.Name = "_lblDescripcion_42"
        Me._lblDescripcion_42.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_42.Size = New System.Drawing.Size(335, 20)
        Me._lblDescripcion_42.TabIndex = 89
        Me._lblDescripcion_42.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me._lblDescripcion_42.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_42, "")
        '
        '_lblEtiqueta_39
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_39, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_39, False)
        Me._lblEtiqueta_39.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_39, "Default")
        Me._lblEtiqueta_39.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_39.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_39.Location = New System.Drawing.Point(10, 165)
        Me._lblEtiqueta_39.Name = "_lblEtiqueta_39"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_39, "500743")
        Me._lblEtiqueta_39.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_39.Size = New System.Drawing.Size(83, 20)
        Me._lblEtiqueta_39.TabIndex = 88
        Me._lblEtiqueta_39.Text = "*Interés Mes:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_39, "")
        '
        '_lblDescripcion_41
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_41, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_41, False)
        Me._lblDescripcion_41.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_41.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_41, "Default")
        Me._lblDescripcion_41.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_41.Location = New System.Drawing.Point(96, 165)
        Me._lblDescripcion_41.Name = "_lblDescripcion_41"
        Me._lblDescripcion_41.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_41.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_41.TabIndex = 27
        Me._lblDescripcion_41.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_41, "")
        '
        '_lblEtiqueta_36
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_36, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_36, False)
        Me._lblEtiqueta_36.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_36, "Default")
        Me._lblEtiqueta_36.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_36.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_36.Location = New System.Drawing.Point(10, 142)
        Me._lblEtiqueta_36.Name = "_lblEtiqueta_36"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_36, "500744")
        Me._lblEtiqueta_36.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_36.Size = New System.Drawing.Size(80, 20)
        Me._lblEtiqueta_36.TabIndex = 86
        Me._lblEtiqueta_36.Text = "*Ult. Interés:"
        Me._lblEtiqueta_36.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_36, "")
        '
        '_lblDescripcion_39
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_39, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_39, False)
        Me._lblDescripcion_39.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_39.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_39, "Default")
        Me._lblDescripcion_39.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_39.Location = New System.Drawing.Point(96, 142)
        Me._lblDescripcion_39.Name = "_lblDescripcion_39"
        Me._lblDescripcion_39.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_39.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_39.TabIndex = 26
        Me._lblDescripcion_39.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me._lblDescripcion_39.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_39, "")
        '
        '_lblDescripcion_38
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_38, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_38, False)
        Me._lblDescripcion_38.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_38.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_38, "Default")
        Me._lblDescripcion_38.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_38.Location = New System.Drawing.Point(109, 103)
        Me._lblDescripcion_38.Name = "_lblDescripcion_38"
        Me._lblDescripcion_38.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_38.Size = New System.Drawing.Size(34, 20)
        Me._lblDescripcion_38.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_38, "")
        '
        '_lblEtiqueta_35
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_35, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_35, False)
        Me._lblEtiqueta_35.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_35, "Default")
        Me._lblEtiqueta_35.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_35.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_35.Location = New System.Drawing.Point(10, 103)
        Me._lblEtiqueta_35.Name = "_lblEtiqueta_35"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_35, "500741")
        Me._lblEtiqueta_35.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_35.Size = New System.Drawing.Size(86, 20)
        Me._lblEtiqueta_35.TabIndex = 83
        Me._lblEtiqueta_35.Text = "*Prod. Banc.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_35, "")
        '
        '_lblDescripcion_37
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_37, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_37, False)
        Me._lblDescripcion_37.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_37.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_37, "Default")
        Me._lblDescripcion_37.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_37.Location = New System.Drawing.Point(146, 103)
        Me._lblDescripcion_37.Name = "_lblDescripcion_37"
        Me._lblDescripcion_37.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_37.Size = New System.Drawing.Size(200, 20)
        Me._lblDescripcion_37.TabIndex = 82
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_37, "")
        '
        '_lblDescripcion_36
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_36, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_36, False)
        Me._lblDescripcion_36.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_36.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_36, "Default")
        Me._lblDescripcion_36.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_36.Location = New System.Drawing.Point(96, 119)
        Me._lblDescripcion_36.Name = "_lblDescripcion_36"
        Me._lblDescripcion_36.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_36.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_36.TabIndex = 25
        Me._lblDescripcion_36.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me._lblDescripcion_36.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_36, "")
        '
        '_lblEtiqueta_53
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_53, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_53, False)
        Me._lblEtiqueta_53.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_53, "Default")
        Me._lblEtiqueta_53.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_53.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_53.Location = New System.Drawing.Point(10, 119)
        Me._lblEtiqueta_53.Name = "_lblEtiqueta_53"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_53, "5147")
        Me._lblEtiqueta_53.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_53.Size = New System.Drawing.Size(87, 20)
        Me._lblEtiqueta_53.TabIndex = 80
        Me._lblEtiqueta_53.Text = "*Tasa Interés:"
        Me._lblEtiqueta_53.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_53, "")
        '
        '_lblEtiqueta_33
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_33, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_33, False)
        Me._lblEtiqueta_33.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_33, "Default")
        Me._lblEtiqueta_33.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_33.ForeColor = System.Drawing.Color.Red
        Me._lblEtiqueta_33.Location = New System.Drawing.Point(10, 234)
        Me._lblEtiqueta_33.Name = "_lblEtiqueta_33"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_33, "500745")
        Me._lblEtiqueta_33.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_33.Size = New System.Drawing.Size(145, 11)
        Me._lblEtiqueta_33.TabIndex = 79
        Me._lblEtiqueta_33.Text = "*MONTO EMBARGADO:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_33, "")
        '
        '_lblDescripcion_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_14, False)
        Me._lblDescripcion_14.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_14.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_14, "Default")
        Me._lblDescripcion_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_14.Location = New System.Drawing.Point(25, 249)
        Me._lblDescripcion_14.Name = "_lblDescripcion_14"
        Me._lblDescripcion_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_14.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_14.TabIndex = 41
        Me._lblDescripcion_14.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_14, "")
        '
        '_lblEtiqueta_22
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_22, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_22, False)
        Me._lblEtiqueta_22.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_22, "Default")
        Me._lblEtiqueta_22.Cursor = System.Windows.Forms.Cursors.Help
        Me._lblEtiqueta_22.ForeColor = System.Drawing.Color.Red
        Me._lblEtiqueta_22.Location = New System.Drawing.Point(10, 234)
        Me._lblEtiqueta_22.Name = "_lblEtiqueta_22"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_22, "501888")
        Me._lblEtiqueta_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_22.Size = New System.Drawing.Size(95, 12)
        Me._lblEtiqueta_22.TabIndex = 8
        Me._lblEtiqueta_22.Text = "*CREDITOS:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_22, "")
        '
        '_lblDescripcion_32
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_32, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_32, False)
        Me._lblDescripcion_32.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_32.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_32, "Default")
        Me._lblDescripcion_32.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_32.Location = New System.Drawing.Point(146, 251)
        Me._lblDescripcion_32.Name = "_lblDescripcion_32"
        Me._lblDescripcion_32.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_32.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_32.TabIndex = 30
        Me._lblDescripcion_32.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_32, "")
        '
        '_lblEtiqueta_26
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_26, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_26, False)
        Me._lblEtiqueta_26.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_26, "Default")
        Me._lblEtiqueta_26.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_26.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_26.Location = New System.Drawing.Point(10, 251)
        Me._lblEtiqueta_26.Name = "_lblEtiqueta_26"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_26, "501889")
        Me._lblEtiqueta_26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_26.Size = New System.Drawing.Size(98, 20)
        Me._lblEtiqueta_26.TabIndex = 10
        Me._lblEtiqueta_26.Text = "*Hoy:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_26, "")
        '
        '_lblDescripcion_33
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_33, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_33, False)
        Me._lblDescripcion_33.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_33.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_33, "Default")
        Me._lblDescripcion_33.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_33.Location = New System.Drawing.Point(146, 272)
        Me._lblDescripcion_33.Name = "_lblDescripcion_33"
        Me._lblDescripcion_33.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_33.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_33.TabIndex = 31
        Me._lblDescripcion_33.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_33, "")
        '
        '_lblEtiqueta_29
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_29, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_29, False)
        Me._lblEtiqueta_29.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_29, "Default")
        Me._lblEtiqueta_29.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_29.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_29.Location = New System.Drawing.Point(10, 272)
        Me._lblEtiqueta_29.Name = "_lblEtiqueta_29"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_29, "501882")
        Me._lblEtiqueta_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_29.Size = New System.Drawing.Size(98, 20)
        Me._lblEtiqueta_29.TabIndex = 74
        Me._lblEtiqueta_29.Text = "*Mes:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_29, "")
        '
        '_lblDescripcion_34
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_34, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_34, False)
        Me._lblDescripcion_34.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_34.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_34, "Default")
        Me._lblDescripcion_34.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_34.Location = New System.Drawing.Point(146, 188)
        Me._lblDescripcion_34.Name = "_lblDescripcion_34"
        Me._lblDescripcion_34.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_34.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_34.TabIndex = 19
        Me._lblDescripcion_34.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_34, "")
        '
        '_lblEtiqueta_30
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_30, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_30, False)
        Me._lblEtiqueta_30.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_30, "Default")
        Me._lblEtiqueta_30.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_30.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_30.Location = New System.Drawing.Point(10, 188)
        Me._lblEtiqueta_30.Name = "_lblEtiqueta_30"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_30, "501889")
        Me._lblEtiqueta_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_30.Size = New System.Drawing.Size(98, 20)
        Me._lblEtiqueta_30.TabIndex = 72
        Me._lblEtiqueta_30.Text = "*Hoy:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_30, "")
        '
        '_lblEtiqueta_38
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_38, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_38, False)
        Me._lblEtiqueta_38.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_38, "Default")
        Me._lblEtiqueta_38.Cursor = System.Windows.Forms.Cursors.Help
        Me._lblEtiqueta_38.ForeColor = System.Drawing.Color.Red
        Me._lblEtiqueta_38.Location = New System.Drawing.Point(10, 169)
        Me._lblEtiqueta_38.Name = "_lblEtiqueta_38"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_38, "501890")
        Me._lblEtiqueta_38.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_38.Size = New System.Drawing.Size(97, 12)
        Me._lblEtiqueta_38.TabIndex = 69
        Me._lblEtiqueta_38.Text = "*DEBITOS:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_38, "")
        '
        '_lblEtiqueta_20
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_20, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_20, False)
        Me._lblEtiqueta_20.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_20, "Default")
        Me._lblEtiqueta_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_20.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_20.Location = New System.Drawing.Point(10, 50)
        Me._lblEtiqueta_20.Name = "_lblEtiqueta_20"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_20, "500766")
        Me._lblEtiqueta_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_20.Size = New System.Drawing.Size(81, 20)
        Me._lblEtiqueta_20.TabIndex = 68
        Me._lblEtiqueta_20.Text = "*Prom. Disp.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_20, "")
        '
        '_lblDescripcion_31
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_31, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_31, False)
        Me._lblDescripcion_31.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_31.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_31, "Default")
        Me._lblDescripcion_31.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_31.Location = New System.Drawing.Point(96, 50)
        Me._lblDescripcion_31.Name = "_lblDescripcion_31"
        Me._lblDescripcion_31.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_31.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_31.TabIndex = 22
        Me._lblDescripcion_31.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_31, "")
        '
        '_lblDescripcion_40
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_40, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_40, False)
        Me._lblDescripcion_40.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_40.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_40, "Default")
        Me._lblDescripcion_40.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_40.Location = New System.Drawing.Point(25, 165)
        Me._lblDescripcion_40.Name = "_lblDescripcion_40"
        Me._lblDescripcion_40.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_40.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_40.TabIndex = 39
        Me._lblDescripcion_40.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_40, "")
        '
        '_lblEtiqueta_19
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_19, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_19, False)
        Me._lblEtiqueta_19.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_19, "Default")
        Me._lblEtiqueta_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_19.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_19.Location = New System.Drawing.Point(10, 165)
        Me._lblEtiqueta_19.Name = "_lblEtiqueta_19"
        Me._lblEtiqueta_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_19.Size = New System.Drawing.Size(12, 20)
        Me._lblEtiqueta_19.TabIndex = 34
        Me._lblEtiqueta_19.Text = "P:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_19, "")
        '
        '_lblDescripcion_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_12, False)
        Me._lblDescripcion_12.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_12.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_12, "Default")
        Me._lblDescripcion_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_12.Location = New System.Drawing.Point(146, 80)
        Me._lblDescripcion_12.Name = "_lblDescripcion_12"
        Me._lblDescripcion_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_12.Size = New System.Drawing.Size(200, 20)
        Me._lblDescripcion_12.TabIndex = 11
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_12, "")
        '
        '_lblEtiqueta_25
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_25, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_25, False)
        Me._lblEtiqueta_25.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_25, "Default")
        Me._lblEtiqueta_25.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_25.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_25.Location = New System.Drawing.Point(10, 80)
        Me._lblEtiqueta_25.Name = "_lblEtiqueta_25"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_25, "501891")
        Me._lblEtiqueta_25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_25.Size = New System.Drawing.Size(86, 20)
        Me._lblEtiqueta_25.TabIndex = 12
        Me._lblEtiqueta_25.Text = "*Capitalización:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_25, "")
        '
        '_lblDescripcion_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_11, False)
        Me._lblDescripcion_11.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_11.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_11, "Default")
        Me._lblDescripcion_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_11.Location = New System.Drawing.Point(109, 80)
        Me._lblDescripcion_11.Name = "_lblDescripcion_11"
        Me._lblDescripcion_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_11.Size = New System.Drawing.Size(34, 20)
        Me._lblDescripcion_11.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_11, "")
        '
        '_lblDescripcion_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_10, False)
        Me._lblDescripcion_10.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_10.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_10, "Default")
        Me._lblDescripcion_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_10.Location = New System.Drawing.Point(145, 56)
        Me._lblDescripcion_10.Name = "_lblDescripcion_10"
        Me._lblDescripcion_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_10.Size = New System.Drawing.Size(116, 20)
        Me._lblDescripcion_10.TabIndex = 14
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_10, "")
        '
        '_lblDescripcion_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_8, False)
        Me._lblDescripcion_8.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_8.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_8, "Default")
        Me._lblDescripcion_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_8.Location = New System.Drawing.Point(146, 11)
        Me._lblDescripcion_8.Name = "_lblDescripcion_8"
        Me._lblDescripcion_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_8.Size = New System.Drawing.Size(200, 20)
        Me._lblDescripcion_8.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_8, "")
        '
        '_lblEtiqueta_28
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_28, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_28, False)
        Me._lblEtiqueta_28.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_28, "Default")
        Me._lblEtiqueta_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_28.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_28.Location = New System.Drawing.Point(10, 11)
        Me._lblEtiqueta_28.Name = "_lblEtiqueta_28"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_28, "500787")
        Me._lblEtiqueta_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_28.Size = New System.Drawing.Size(86, 20)
        Me._lblEtiqueta_28.TabIndex = 16
        Me._lblEtiqueta_28.Text = "*Oficial cta.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_28, "")
        '
        '_lblDescripcion_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_7, False)
        Me._lblDescripcion_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_7, "Default")
        Me._lblDescripcion_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_7.Location = New System.Drawing.Point(109, 11)
        Me._lblDescripcion_7.Name = "_lblDescripcion_7"
        Me._lblDescripcion_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_7.Size = New System.Drawing.Size(34, 20)
        Me._lblDescripcion_7.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_7, "")
        '
        '_lblDescripcion_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_6, False)
        Me._lblDescripcion_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_6, "Default")
        Me._lblDescripcion_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_6.Location = New System.Drawing.Point(146, 57)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(200, 20)
        Me._lblDescripcion_6.TabIndex = 18
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_6, "")
        '
        '_lblEtiqueta_27
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_27, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_27, False)
        Me._lblEtiqueta_27.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_27, "Default")
        Me._lblEtiqueta_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_27.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_27.Location = New System.Drawing.Point(10, 57)
        Me._lblEtiqueta_27.Name = "_lblEtiqueta_27"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_27, "500786")
        Me._lblEtiqueta_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_27.Size = New System.Drawing.Size(86, 20)
        Me._lblEtiqueta_27.TabIndex = 19
        Me._lblEtiqueta_27.Text = "*Categoría:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_27, "")
        '
        '_lblDescripcion_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_5, False)
        Me._lblDescripcion_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_5, "Default")
        Me._lblDescripcion_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_5.Location = New System.Drawing.Point(109, 57)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(34, 20)
        Me._lblDescripcion_5.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_5, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(145, 33)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(116, 20)
        Me._lblDescripcion_4.TabIndex = 21
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(10, 34)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "5067")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(64, 14)
        Me._lblEtiqueta_9.TabIndex = 22
        Me._lblEtiqueta_9.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(106, 33)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(35, 20)
        Me._lblDescripcion_3.TabIndex = 9
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(146, 34)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(200, 20)
        Me._lblDescripcion_2.TabIndex = 24
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(10, 34)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "5209")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(86, 20)
        Me._lblEtiqueta_7.TabIndex = 25
        Me._lblEtiqueta_7.Text = "*Moneda:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(109, 34)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(34, 20)
        Me._lblDescripcion_1.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 73)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "5081")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(98, 20)
        Me._lblEtiqueta_5.TabIndex = 27
        Me._lblEtiqueta_5.Text = "*Chq Exterior:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblDescripcion_29
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_29, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_29, False)
        Me._lblDescripcion_29.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_29.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_29, "Default")
        Me._lblDescripcion_29.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_29.Location = New System.Drawing.Point(25, 212)
        Me._lblDescripcion_29.Name = "_lblDescripcion_29"
        Me._lblDescripcion_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_29.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_29.TabIndex = 40
        Me._lblDescripcion_29.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_29, "")
        '
        '_lblEtiqueta_24
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_24, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_24, False)
        Me._lblEtiqueta_24.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_24, "Default")
        Me._lblEtiqueta_24.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_24.ForeColor = System.Drawing.Color.Red
        Me._lblEtiqueta_24.Location = New System.Drawing.Point(10, 196)
        Me._lblEtiqueta_24.Name = "_lblEtiqueta_24"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_24, "501892")
        Me._lblEtiqueta_24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_24.Size = New System.Drawing.Size(157, 12)
        Me._lblEtiqueta_24.TabIndex = 28
        Me._lblEtiqueta_24.Text = "*MONTOS BLOQUEADOS:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_24, "")
        '
        '_lblDescripcion_22
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_22, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_22, False)
        Me._lblDescripcion_22.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_22.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_22, "Default")
        Me._lblDescripcion_22.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_22.Location = New System.Drawing.Point(96, 188)
        Me._lblDescripcion_22.Name = "_lblDescripcion_22"
        Me._lblDescripcion_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_22.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_22.TabIndex = 28
        Me._lblDescripcion_22.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me._lblDescripcion_22.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_22, "")
        '
        '_lblEtiqueta_23
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_23, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_23, False)
        Me._lblEtiqueta_23.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_23, "Default")
        Me._lblEtiqueta_23.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_23.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_23.Location = New System.Drawing.Point(10, 188)
        Me._lblEtiqueta_23.Name = "_lblEtiqueta_23"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_23, "500742")
        Me._lblEtiqueta_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_23.Size = New System.Drawing.Size(82, 20)
        Me._lblEtiqueta_23.TabIndex = 30
        Me._lblEtiqueta_23.Text = "*Int. Periodo:"
        Me._lblEtiqueta_23.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_23, "")
        '
        '_lblDescripcion_30
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_30, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_30, False)
        Me._lblDescripcion_30.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_30.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_30, "Default")
        Me._lblDescripcion_30.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_30.Location = New System.Drawing.Point(145, 10)
        Me._lblDescripcion_30.Name = "_lblDescripcion_30"
        Me._lblDescripcion_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_30.Size = New System.Drawing.Size(116, 20)
        Me._lblDescripcion_30.TabIndex = 8
        Me._lblDescripcion_30.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_30, "")
        '
        '_lblEtiqueta_18
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_18, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_18, False)
        Me._lblEtiqueta_18.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_18, "Default")
        Me._lblEtiqueta_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_18.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_18.Location = New System.Drawing.Point(10, 11)
        Me._lblEtiqueta_18.Name = "_lblEtiqueta_18"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_18, "501893")
        Me._lblEtiqueta_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_18.Size = New System.Drawing.Size(82, 15)
        Me._lblEtiqueta_18.TabIndex = 36
        Me._lblEtiqueta_18.Text = "*Ultimo Mov:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_18, "")
        '
        '_lblDescripcion_28
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_28, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_28, False)
        Me._lblDescripcion_28.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_28.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_28, "Default")
        Me._lblDescripcion_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_28.Location = New System.Drawing.Point(25, 142)
        Me._lblDescripcion_28.Name = "_lblDescripcion_28"
        Me._lblDescripcion_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_28.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_28.TabIndex = 37
        Me._lblDescripcion_28.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_28, "")
        '
        '_lblEtiqueta_17
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_17, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_17, False)
        Me._lblEtiqueta_17.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_17, "Default")
        Me._lblEtiqueta_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_17.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_17.Location = New System.Drawing.Point(10, 142)
        Me._lblEtiqueta_17.Name = "_lblEtiqueta_17"
        Me._lblEtiqueta_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_17.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_17.TabIndex = 38
        Me._lblEtiqueta_17.Text = "6:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_17, "")
        '
        '_lblDescripcion_27
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_27, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_27, False)
        Me._lblDescripcion_27.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_27.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_27, "Default")
        Me._lblDescripcion_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_27.Location = New System.Drawing.Point(25, 119)
        Me._lblDescripcion_27.Name = "_lblDescripcion_27"
        Me._lblDescripcion_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_27.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_27.TabIndex = 39
        Me._lblDescripcion_27.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_27, "")
        '
        '_lblEtiqueta_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_16, False)
        Me._lblEtiqueta_16.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_16, "Default")
        Me._lblEtiqueta_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_16.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_16.Location = New System.Drawing.Point(10, 119)
        Me._lblEtiqueta_16.Name = "_lblEtiqueta_16"
        Me._lblEtiqueta_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_16.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_16.TabIndex = 40
        Me._lblEtiqueta_16.Text = "5:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_16, "")
        '
        '_lblDescripcion_26
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_26, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_26, False)
        Me._lblDescripcion_26.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_26.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_26, "Default")
        Me._lblDescripcion_26.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_26.Location = New System.Drawing.Point(25, 96)
        Me._lblDescripcion_26.Name = "_lblDescripcion_26"
        Me._lblDescripcion_26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_26.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_26.TabIndex = 41
        Me._lblDescripcion_26.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_26, "")
        '
        '_lblEtiqueta_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_15, False)
        Me._lblEtiqueta_15.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_15, "Default")
        Me._lblEtiqueta_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_15.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_15.Location = New System.Drawing.Point(10, 96)
        Me._lblEtiqueta_15.Name = "_lblEtiqueta_15"
        Me._lblEtiqueta_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_15.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_15.TabIndex = 42
        Me._lblEtiqueta_15.Text = "4:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_15, "")
        '
        '_lblDescripcion_25
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_25, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_25, False)
        Me._lblDescripcion_25.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_25.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_25, "Default")
        Me._lblDescripcion_25.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_25.Location = New System.Drawing.Point(25, 73)
        Me._lblDescripcion_25.Name = "_lblDescripcion_25"
        Me._lblDescripcion_25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_25.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_25.TabIndex = 43
        Me._lblDescripcion_25.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_25, "")
        '
        '_lblEtiqueta_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_14, False)
        Me._lblEtiqueta_14.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_14, "Default")
        Me._lblEtiqueta_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_14.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_14.Location = New System.Drawing.Point(10, 73)
        Me._lblEtiqueta_14.Name = "_lblEtiqueta_14"
        Me._lblEtiqueta_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_14.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_14.TabIndex = 44
        Me._lblEtiqueta_14.Text = "3:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_14, "")
        '
        '_lblDescripcion_24
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_24, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_24, False)
        Me._lblDescripcion_24.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_24.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_24, "Default")
        Me._lblDescripcion_24.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_24.Location = New System.Drawing.Point(25, 50)
        Me._lblDescripcion_24.Name = "_lblDescripcion_24"
        Me._lblDescripcion_24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_24.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_24.TabIndex = 45
        Me._lblDescripcion_24.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_24, "")
        '
        '_lblEtiqueta_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_13, False)
        Me._lblEtiqueta_13.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_13, "Default")
        Me._lblEtiqueta_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_13.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_13.Location = New System.Drawing.Point(10, 50)
        Me._lblEtiqueta_13.Name = "_lblEtiqueta_13"
        Me._lblEtiqueta_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_13.Size = New System.Drawing.Size(10, 20)
        Me._lblEtiqueta_13.TabIndex = 46
        Me._lblEtiqueta_13.Text = "2:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_13, "")
        '
        '_lblDescripcion_23
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_23, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_23, False)
        Me._lblDescripcion_23.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_23.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_23, "Default")
        Me._lblDescripcion_23.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_23.Location = New System.Drawing.Point(25, 27)
        Me._lblDescripcion_23.Name = "_lblDescripcion_23"
        Me._lblDescripcion_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_23.Size = New System.Drawing.Size(127, 20)
        Me._lblDescripcion_23.TabIndex = 47
        Me._lblDescripcion_23.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_23, "")
        '
        '_lblEtiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_12, False)
        Me._lblEtiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_12, "Default")
        Me._lblEtiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_12.Location = New System.Drawing.Point(10, 27)
        Me._lblEtiqueta_12.Name = "_lblEtiqueta_12"
        Me._lblEtiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_12.Size = New System.Drawing.Size(8, 20)
        Me._lblEtiqueta_12.TabIndex = 48
        Me._lblEtiqueta_12.Text = "1:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_12, "")
        '
        '_lblDescripcion_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_9, False)
        Me._lblDescripcion_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_9, "Default")
        Me._lblDescripcion_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_9.Location = New System.Drawing.Point(106, 56)
        Me._lblDescripcion_9.Name = "_lblDescripcion_9"
        Me._lblDescripcion_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_9.Size = New System.Drawing.Size(35, 20)
        Me._lblDescripcion_9.TabIndex = 10
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_9, "")
        '
        '_lblEtiqueta_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_11, False)
        Me._lblEtiqueta_11.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_11, "Default")
        Me._lblEtiqueta_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_11.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_11.Location = New System.Drawing.Point(10, 57)
        Me._lblEtiqueta_11.Name = "_lblEtiqueta_11"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_11, "501894")
        Me._lblEtiqueta_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_11.Size = New System.Drawing.Size(64, 15)
        Me._lblEtiqueta_11.TabIndex = 50
        Me._lblEtiqueta_11.Text = "*T. Prom:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_11, "")
        '
        '_lblEtiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(10, 96)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "500777")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(83, 20)
        Me._lblEtiqueta_10.TabIndex = 51
        Me._lblEtiqueta_10.Text = "*Disp. a Girar:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        '_lblDescripcion_20
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_20, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_20, False)
        Me._lblDescripcion_20.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_20.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_20, "Default")
        Me._lblDescripcion_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_20.Location = New System.Drawing.Point(96, 73)
        Me._lblDescripcion_20.Name = "_lblDescripcion_20"
        Me._lblDescripcion_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_20.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_20.TabIndex = 23
        Me._lblDescripcion_20.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_20, "")
        '
        '_lblDescripcion_19
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_19, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_19, False)
        Me._lblDescripcion_19.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_19.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_19, "Default")
        Me._lblDescripcion_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_19.Location = New System.Drawing.Point(96, 27)
        Me._lblDescripcion_19.Name = "_lblDescripcion_19"
        Me._lblDescripcion_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_19.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_19.TabIndex = 21
        Me._lblDescripcion_19.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_19, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(10, 96)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "501895")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(98, 20)
        Me._lblEtiqueta_8.TabIndex = 54
        Me._lblEtiqueta_8.Text = "*Chq exterior hoy:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblDescripcion_18
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_18, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_18, False)
        Me._lblDescripcion_18.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_18.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_18, "Default")
        Me._lblDescripcion_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_18.Location = New System.Drawing.Point(146, 50)
        Me._lblDescripcion_18.Name = "_lblDescripcion_18"
        Me._lblDescripcion_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_18.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_18.TabIndex = 17
        Me._lblDescripcion_18.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_18, "")
        '
        '_lblDescripcion_17
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_17, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_17, False)
        Me._lblDescripcion_17.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_17.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_17, "Default")
        Me._lblDescripcion_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_17.Location = New System.Drawing.Point(146, 27)
        Me._lblDescripcion_17.Name = "_lblDescripcion_17"
        Me._lblDescripcion_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_17.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_17.TabIndex = 16
        Me._lblDescripcion_17.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_17, "")
        '
        '_lblDescripcion_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_16, False)
        Me._lblDescripcion_16.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_16.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_16, "Default")
        Me._lblDescripcion_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_16.Location = New System.Drawing.Point(146, 96)
        Me._lblDescripcion_16.Name = "_lblDescripcion_16"
        Me._lblDescripcion_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_16.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_16.TabIndex = 15
        Me._lblDescripcion_16.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_16, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(10, 27)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "500775")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(98, 20)
        Me._lblEtiqueta_4.TabIndex = 58
        Me._lblEtiqueta_4.Text = "*Libera prox. dia:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblDescripcion_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_15, False)
        Me._lblDescripcion_15.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_15.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_15, "Default")
        Me._lblDescripcion_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_15.Location = New System.Drawing.Point(146, 73)
        Me._lblDescripcion_15.Name = "_lblDescripcion_15"
        Me._lblDescripcion_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_15.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_15.TabIndex = 14
        Me._lblDescripcion_15.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_15, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 50)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "500774")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(98, 20)
        Me._lblEtiqueta_3.TabIndex = 60
        Me._lblEtiqueta_3.Text = "*A Liberar Hoy:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 27)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "500773")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(82, 20)
        Me._lblEtiqueta_2.TabIndex = 61
        Me._lblEtiqueta_2.Text = "*Disponible:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblDescripcion_21
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_21, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_21, False)
        Me._lblDescripcion_21.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_21.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_21, "Default")
        Me._lblDescripcion_21.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_21.Location = New System.Drawing.Point(96, 96)
        Me._lblDescripcion_21.Name = "_lblDescripcion_21"
        Me._lblDescripcion_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_21.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_21.TabIndex = 24
        Me._lblDescripcion_21.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_21, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 73)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "501896")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(88, 20)
        Me._lblEtiqueta_1.TabIndex = 63
        Me._lblEtiqueta_1.Text = "*Sld Contable:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_31
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_31, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_31, False)
        Me._lblEtiqueta_31.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_31, "Default")
        Me._lblEtiqueta_31.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_31.ForeColor = System.Drawing.Color.Red
        Me._lblEtiqueta_31.Location = New System.Drawing.Point(10, 6)
        Me._lblEtiqueta_31.Name = "_lblEtiqueta_31"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_31, "500771")
        Me._lblEtiqueta_31.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_31.Size = New System.Drawing.Size(74, 13)
        Me._lblEtiqueta_31.TabIndex = 35
        Me._lblEtiqueta_31.Text = "*RESERVAS"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_31, "")
        '
        '_lblEtiqueta_32
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_32, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_32, False)
        Me._lblEtiqueta_32.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_32, "Default")
        Me._lblEtiqueta_32.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_32.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_32.Location = New System.Drawing.Point(10, 8)
        Me._lblEtiqueta_32.Name = "_lblEtiqueta_32"
        Me._lblEtiqueta_32.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_32.Size = New System.Drawing.Size(110, 13)
        Me._lblEtiqueta_32.TabIndex = 65
        Me._lblEtiqueta_32.Text = "PROMEDIOS"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_32, "")
        '
        '_lblEtiqueta_34
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_34, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_34, False)
        Me._lblEtiqueta_34.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_34, "Default")
        Me._lblEtiqueta_34.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_34.ForeColor = System.Drawing.Color.Red
        Me._lblEtiqueta_34.Location = New System.Drawing.Point(10, 6)
        Me._lblEtiqueta_34.Name = "_lblEtiqueta_34"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_34, "500768")
        Me._lblEtiqueta_34.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_34.Size = New System.Drawing.Size(73, 14)
        Me._lblEtiqueta_34.TabIndex = 64
        Me._lblEtiqueta_34.Text = "*SALDOS"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_34, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(156, 33)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(477, 20)
        Me._lblDescripcion_0.TabIndex = 7
        Me._lblDescripcion_0.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(20, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "2300")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(119, 20)
        Me._lblEtiqueta_0.TabIndex = 6
        Me._lblEtiqueta_0.Text = "*No. de cuenta ahorro:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(20, 33)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500108")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(119, 20)
        Me._lblEtiqueta_6.TabIndex = 5
        Me._lblEtiqueta_6.Text = "*Nombre de la cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblDescripcion_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_13, False)
        Me._lblDescripcion_13.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_13.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_13, "Default")
        Me._lblDescripcion_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_13.Location = New System.Drawing.Point(146, 211)
        Me._lblDescripcion_13.Name = "_lblDescripcion_13"
        Me._lblDescripcion_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_13.Size = New System.Drawing.Size(101, 20)
        Me._lblDescripcion_13.TabIndex = 20
        Me._lblDescripcion_13.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me._lblDescripcion_13.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_13, "")
        '
        '_lblEtiqueta_21
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_21, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_21, False)
        Me._lblEtiqueta_21.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_21, "Default")
        Me._lblEtiqueta_21.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_21.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_21.Location = New System.Drawing.Point(10, 211)
        Me._lblEtiqueta_21.Name = "_lblEtiqueta_21"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_21, "500746")
        Me._lblEtiqueta_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_21.Size = New System.Drawing.Size(98, 20)
        Me._lblEtiqueta_21.TabIndex = 76
        Me._lblEtiqueta_21.Text = "*IDB Mes:"
        Me._lblEtiqueta_21.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_21, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox5)
        Me.PFormas.Controls.Add(Me.UltraGroupBox3)
        Me.PFormas.Controls.Add(Me.UltraGroupBox2)
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.PFormas.Controls.Add(Me.mskCuenta)
        Me.PFormas.Controls.Add(Me.lbldesalianza)
        Me.PFormas.Controls.Add(Me.Lblalianza)
        Me.PFormas.Controls.Add(Me.Label5)
        Me.PFormas.Controls.Add(Me._lblDescripcion_42)
        Me.PFormas.Controls.Add(Me.frmhistcredeb)
        Me.PFormas.Controls.Add(Me.UltraGroupBox4)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(661, 590)
        Me.PFormas.TabIndex = 137
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox5, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox5, False)
        Me.UltraGroupBox5.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox5.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_34)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_19)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_20)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_31)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_10)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_20)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_54)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_56)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_39)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_41)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_36)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_39)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_36)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_2)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_23)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_53)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_22)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_1)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_21)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox5, "Default")
        Me.UltraGroupBox5.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox5.Location = New System.Drawing.Point(268, 237)
        Me.UltraGroupBox5.Name = "UltraGroupBox5"
        Me.UltraGroupBox5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox5.Size = New System.Drawing.Size(209, 319)
        Me.UltraGroupBox5.TabIndex = 141
        Me.UltraGroupBox5.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox5, "")
        '
        'UltraGroupBox3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox3, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox3, False)
        Me.UltraGroupBox3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox3.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_17)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_21)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_37)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_13)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_38)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_30)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_34)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_29)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_33)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_26)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_31)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_32)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_5)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_22)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_3)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_56)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_15)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_59)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_4)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_35)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_8)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_18)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_16)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox3, "Default")
        Me.UltraGroupBox3.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox3.Location = New System.Drawing.Point(10, 237)
        Me.UltraGroupBox3.Name = "UltraGroupBox3"
        Me.UltraGroupBox3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox3.Size = New System.Drawing.Size(257, 319)
        Me.UltraGroupBox3.TabIndex = 139
        Me.UltraGroupBox3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox3, "")
        '
        'UltraGroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox2.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_30)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_10)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_4)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_9)
        Me.UltraGroupBox2.Controls.Add(Me.FrmTarjetaDeb)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_3)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_18)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_57)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_58)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_9)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_55)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_11)
        Me.UltraGroupBox2.Controls.Add(Me.LblTarjetaDeb)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox2.Location = New System.Drawing.Point(372, 57)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.UltraGroupBox2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox2.Size = New System.Drawing.Size(277, 179)
        Me.UltraGroupBox2.TabIndex = 138
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_8)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_11)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_25)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_12)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_28)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_7)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_6)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_27)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_5)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_7)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_1)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_37)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_35)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_38)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_71)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_60)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_57)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_61)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 57)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox1.Size = New System.Drawing.Size(361, 179)
        Me.UltraGroupBox1.TabIndex = 137
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'frmhistcredeb
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmhistcredeb, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmhistcredeb, False)
        Me.frmhistcredeb.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmhistcredeb.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.frmhistcredeb.Controls.Add(Me.frmhistcre)
        Me.frmhistcredeb.Controls.Add(Me.frmhistdeb)
        Me.COBISStyleProvider.SetControlStyle(Me.frmhistcredeb, "Default")
        Me.frmhistcredeb.ForeColor = System.Drawing.Color.Navy
        Me.frmhistcredeb.Location = New System.Drawing.Point(478, 237)
        Me.frmhistcredeb.Name = "frmhistcredeb"
        Me.frmhistcredeb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmhistcredeb.Size = New System.Drawing.Size(171, 185)
        Me.frmhistcredeb.TabIndex = 142
        Me.frmhistcredeb.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.frmhistcredeb.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmhistcredeb, "")
        '
        'UltraGroupBox4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox4, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox4, False)
        Me.UltraGroupBox4.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox4.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_29)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_14)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_33)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_40)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_43)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_12)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_32)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_23)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_13)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_27)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_24)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_19)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_14)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_40)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_25)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_28)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_15)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_26)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_17)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_16)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_24)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox4, "Default")
        Me.UltraGroupBox4.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox4.Location = New System.Drawing.Point(478, 237)
        Me.UltraGroupBox4.Name = "UltraGroupBox4"
        Me.UltraGroupBox4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox4.Size = New System.Drawing.Size(171, 319)
        Me.UltraGroupBox4.TabIndex = 140
        Me.UltraGroupBox4.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox4, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBFirmas, Me.TSBImprimir, Me.TSBExcel, Me.TSBTransmitir, Me.TSBSiguientes, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(681, 25)
        Me.TSBotones.TabIndex = 138
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBFirmas
        '
        Me.TSBFirmas.ForeColor = System.Drawing.Color.Black
        Me.TSBFirmas.Image = CType(resources.GetObject("TSBFirmas.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBFirmas, "2027")
        Me.TSBFirmas.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBFirmas.Name = "TSBFirmas"
        Me.COBISResourceProvider.SetResourceID(Me.TSBFirmas, "2027")
        Me.TSBFirmas.Size = New System.Drawing.Size(62, 22)
        Me.TSBFirmas.Text = "*&Firma"
        Me.TSBFirmas.Visible = False
        '
        'TSBImprimir
        '
        Me.TSBImprimir.ForeColor = System.Drawing.Color.Black
        Me.TSBImprimir.Image = CType(resources.GetObject("TSBImprimir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBImprimir.Name = "TSBImprimir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.Size = New System.Drawing.Size(78, 22)
        Me.TSBImprimir.Text = "*&Imprimir"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBExcel
        '
        Me.TSBExcel.ForeColor = System.Drawing.Color.Black
        Me.TSBExcel.Image = CType(resources.GetObject("TSBExcel.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBExcel, "2500")
        Me.TSBExcel.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBExcel.Name = "TSBExcel"
        Me.COBISResourceProvider.SetResourceID(Me.TSBExcel, "2068")
        Me.TSBExcel.Size = New System.Drawing.Size(58, 22)
        Me.TSBExcel.Text = "*&Excel"
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2020")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "2040")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Text = "*&Siguientes"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        '_cmdBoton_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_7, False)
        Me._cmdBoton_7.BackColor = System.Drawing.SystemColors.Control
        Me._cmdBoton_7.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_7, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_7, True)
        Me._cmdBoton_7.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_7, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_7, Nothing)
        Me._cmdBoton_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_7.Location = New System.Drawing.Point(-700, 384)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_7, System.Drawing.Color.Silver)
        Me._cmdBoton_7.Name = "_cmdBoton_7"
        Me._cmdBoton_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_7.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_7, 1)
        Me._cmdBoton_7.TabIndex = 139
        Me._cmdBoton_7.Text = "*&Excel"
        Me._cmdBoton_7.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_7.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_7, "")
        '
        'Ftran220Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._cmdBoton_3)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_6)
        Me.Controls.Add(Me._cmdBoton_7)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(102, 145)
        Me.Name = "Ftran220Class"
        Me.COBISResourceProvider.SetResourceID(Me, "509517")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(681, 636)
        Me.Tag = "3021"
        Me.Text = "*Consulta Monetaria a la Cuenta de Ahorros"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.FrmTarjetaDeb, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FrmTarjetaDeb.ResumeLayout(False)
        CType(Me.frmhistdeb, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmhistdeb.ResumeLayout(False)
        CType(Me.frmhistcre, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmhistcre.ResumeLayout(False)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.UltraGroupBox5, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox5.ResumeLayout(False)
        CType(Me.UltraGroupBox3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox3.ResumeLayout(False)
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox2.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        CType(Me.frmhistcredeb, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmhistcredeb.ResumeLayout(False)
        CType(Me.UltraGroupBox4, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox4.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptTarjetaDebito()
        Me.optTarjetaDebito(0) = _optTarjetaDebito_0
        Me.optTarjetaDebito(1) = _optTarjetaDebito_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(52) = _lblEtiqueta_52
        Me.lblEtiqueta(51) = _lblEtiqueta_51
        Me.lblEtiqueta(50) = _lblEtiqueta_50
        Me.lblEtiqueta(49) = _lblEtiqueta_49
        Me.lblEtiqueta(48) = _lblEtiqueta_48
        Me.lblEtiqueta(47) = _lblEtiqueta_47
        Me.lblEtiqueta(46) = _lblEtiqueta_46
        Me.lblEtiqueta(45) = _lblEtiqueta_45
        Me.lblEtiqueta(44) = _lblEtiqueta_44
        Me.lblEtiqueta(43) = _lblEtiqueta_43
        Me.lblEtiqueta(42) = _lblEtiqueta_42
        Me.lblEtiqueta(41) = _lblEtiqueta_41
        Me.lblEtiqueta(57) = _lblEtiqueta_57
        Me.lblEtiqueta(71) = _lblEtiqueta_71
        Me.lblEtiqueta(37) = _lblEtiqueta_37
        Me.lblEtiqueta(56) = _lblEtiqueta_56
        Me.lblEtiqueta(55) = _lblEtiqueta_55
        Me.lblEtiqueta(54) = _lblEtiqueta_54
        Me.lblEtiqueta(40) = _lblEtiqueta_40
        Me.lblEtiqueta(39) = _lblEtiqueta_39
        Me.lblEtiqueta(36) = _lblEtiqueta_36
        Me.lblEtiqueta(35) = _lblEtiqueta_35
        Me.lblEtiqueta(53) = _lblEtiqueta_53
        Me.lblEtiqueta(33) = _lblEtiqueta_33
        Me.lblEtiqueta(22) = _lblEtiqueta_22
        Me.lblEtiqueta(26) = _lblEtiqueta_26
        Me.lblEtiqueta(29) = _lblEtiqueta_29
        Me.lblEtiqueta(30) = _lblEtiqueta_30
        Me.lblEtiqueta(38) = _lblEtiqueta_38
        Me.lblEtiqueta(20) = _lblEtiqueta_20
        Me.lblEtiqueta(19) = _lblEtiqueta_19
        Me.lblEtiqueta(25) = _lblEtiqueta_25
        Me.lblEtiqueta(28) = _lblEtiqueta_28
        Me.lblEtiqueta(27) = _lblEtiqueta_27
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(24) = _lblEtiqueta_24
        Me.lblEtiqueta(23) = _lblEtiqueta_23
        Me.lblEtiqueta(18) = _lblEtiqueta_18
        Me.lblEtiqueta(17) = _lblEtiqueta_17
        Me.lblEtiqueta(16) = _lblEtiqueta_16
        Me.lblEtiqueta(15) = _lblEtiqueta_15
        Me.lblEtiqueta(14) = _lblEtiqueta_14
        Me.lblEtiqueta(13) = _lblEtiqueta_13
        Me.lblEtiqueta(12) = _lblEtiqueta_12
        Me.lblEtiqueta(11) = _lblEtiqueta_11
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(31) = _lblEtiqueta_31
        Me.lblEtiqueta(32) = _lblEtiqueta_32
        Me.lblEtiqueta(34) = _lblEtiqueta_34
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(21) = _lblEtiqueta_21
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(45) = _lblDescripcion_45
        Me.lblDescripcion(46) = _lblDescripcion_46
        Me.lblDescripcion(47) = _lblDescripcion_47
        Me.lblDescripcion(48) = _lblDescripcion_48
        Me.lblDescripcion(49) = _lblDescripcion_49
        Me.lblDescripcion(44) = _lblDescripcion_44
        Me.lblDescripcion(50) = _lblDescripcion_50
        Me.lblDescripcion(51) = _lblDescripcion_51
        Me.lblDescripcion(52) = _lblDescripcion_52
        Me.lblDescripcion(53) = _lblDescripcion_53
        Me.lblDescripcion(54) = _lblDescripcion_54
        Me.lblDescripcion(55) = _lblDescripcion_55
        Me.lblDescripcion(61) = _lblDescripcion_61
        Me.lblDescripcion(60) = _lblDescripcion_60
        Me.lblDescripcion(35) = _lblDescripcion_35
        Me.lblDescripcion(59) = _lblDescripcion_59
        Me.lblDescripcion(58) = _lblDescripcion_58
        Me.lblDescripcion(57) = _lblDescripcion_57
        Me.lblDescripcion(56) = _lblDescripcion_56
        Me.lblDescripcion(43) = _lblDescripcion_43
        Me.lblDescripcion(42) = _lblDescripcion_42
        Me.lblDescripcion(41) = _lblDescripcion_41
        Me.lblDescripcion(39) = _lblDescripcion_39
        Me.lblDescripcion(38) = _lblDescripcion_38
        Me.lblDescripcion(37) = _lblDescripcion_37
        Me.lblDescripcion(36) = _lblDescripcion_36
        Me.lblDescripcion(14) = _lblDescripcion_14
        Me.lblDescripcion(32) = _lblDescripcion_32
        Me.lblDescripcion(33) = _lblDescripcion_33
        Me.lblDescripcion(34) = _lblDescripcion_34
        Me.lblDescripcion(31) = _lblDescripcion_31
        Me.lblDescripcion(40) = _lblDescripcion_40
        Me.lblDescripcion(12) = _lblDescripcion_12
        Me.lblDescripcion(11) = _lblDescripcion_11
        Me.lblDescripcion(10) = _lblDescripcion_10
        Me.lblDescripcion(8) = _lblDescripcion_8
        Me.lblDescripcion(7) = _lblDescripcion_7
        Me.lblDescripcion(6) = _lblDescripcion_6
        Me.lblDescripcion(5) = _lblDescripcion_5
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(29) = _lblDescripcion_29
        Me.lblDescripcion(22) = _lblDescripcion_22
        Me.lblDescripcion(30) = _lblDescripcion_30
        Me.lblDescripcion(28) = _lblDescripcion_28
        Me.lblDescripcion(27) = _lblDescripcion_27
        Me.lblDescripcion(26) = _lblDescripcion_26
        Me.lblDescripcion(25) = _lblDescripcion_25
        Me.lblDescripcion(24) = _lblDescripcion_24
        Me.lblDescripcion(23) = _lblDescripcion_23
        Me.lblDescripcion(9) = _lblDescripcion_9
        Me.lblDescripcion(20) = _lblDescripcion_20
        Me.lblDescripcion(19) = _lblDescripcion_19
        Me.lblDescripcion(18) = _lblDescripcion_18
        Me.lblDescripcion(17) = _lblDescripcion_17
        Me.lblDescripcion(16) = _lblDescripcion_16
        Me.lblDescripcion(15) = _lblDescripcion_15
        Me.lblDescripcion(21) = _lblDescripcion_21
        Me.lblDescripcion(0) = _lblDescripcion_0
        Me.lblDescripcion(13) = _lblDescripcion_13
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(6) = _cmdBoton_6
        Me.cmdBoton(7) = _cmdBoton_7
    End Sub

    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBFirmas As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBImprimir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Public WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents UltraGroupBox3 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents UltraGroupBox5 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents UltraGroupBox4 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents frmhistcredeb As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBExcel As System.Windows.Forms.ToolStripButton
#End Region
End Class


