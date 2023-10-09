Imports COBISCorp.tCOBIS.TADMIN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FTran235Class
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
    Private WithEvents _optTarjetaDebito_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optTarjetaDebito_0 As System.Windows.Forms.RadioButton
    Public WithEvents FrmTarjetaDeb As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents grdBloqueos As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents grdPropietarios As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Public WithEvents LblTarjetaDeb As System.Windows.Forms.Label
    Public WithEvents Label5 As System.Windows.Forms.Label
    Public WithEvents Lblalianza As System.Windows.Forms.Label
    Public WithEvents lbldesalianza As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_34 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_29 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_32 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_28 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_33 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_31 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_57 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_30 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_27 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_21 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_31 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_7 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_10 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_11 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_12 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_13 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_18 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_13 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_19 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_16 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_14 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_17 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_20 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_15 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_21 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_24 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_16 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_25 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_26 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_17 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_27 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_28 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_18 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_29 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_14 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_22 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_15 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_22 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_23 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_23 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_24 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_25 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Public Line1(2) As System.Windows.Forms.Label
    Public cmdBoton(6) As System.Windows.Forms.Button
    Public lblDescripcion(57) As System.Windows.Forms.Label
    Public lblEtiqueta(31) As System.Windows.Forms.Label
    Public optTarjetaDebito(1) As System.Windows.Forms.RadioButton
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran235Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.FrmTarjetaDeb = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optTarjetaDebito_1 = New System.Windows.Forms.RadioButton()
        Me._optTarjetaDebito_0 = New System.Windows.Forms.RadioButton()
        Me.grdBloqueos = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.grdPropietarios = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me.LblTarjetaDeb = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Lblalianza = New System.Windows.Forms.Label()
        Me.lbldesalianza = New System.Windows.Forms.Label()
        Me._lblDescripcion_34 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_29 = New System.Windows.Forms.Label()
        Me._lblDescripcion_32 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_28 = New System.Windows.Forms.Label()
        Me._lblDescripcion_33 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_31 = New System.Windows.Forms.Label()
        Me._lblDescripcion_57 = New System.Windows.Forms.Label()
        Me._lblDescripcion_30 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_27 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_21 = New System.Windows.Forms.Label()
        Me._lblDescripcion_31 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_7 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_10 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_11 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_12 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_12 = New System.Windows.Forms.Label()
        Me._lblDescripcion_13 = New System.Windows.Forms.Label()
        Me._lblDescripcion_18 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_13 = New System.Windows.Forms.Label()
        Me._lblDescripcion_19 = New System.Windows.Forms.Label()
        Me._lblDescripcion_16 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_14 = New System.Windows.Forms.Label()
        Me._lblDescripcion_17 = New System.Windows.Forms.Label()
        Me._lblDescripcion_20 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_15 = New System.Windows.Forms.Label()
        Me._lblDescripcion_21 = New System.Windows.Forms.Label()
        Me._lblDescripcion_24 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_16 = New System.Windows.Forms.Label()
        Me._lblDescripcion_25 = New System.Windows.Forms.Label()
        Me._lblDescripcion_26 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_17 = New System.Windows.Forms.Label()
        Me._lblDescripcion_27 = New System.Windows.Forms.Label()
        Me._lblDescripcion_28 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_18 = New System.Windows.Forms.Label()
        Me._lblDescripcion_29 = New System.Windows.Forms.Label()
        Me._lblDescripcion_14 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_22 = New System.Windows.Forms.Label()
        Me._lblDescripcion_15 = New System.Windows.Forms.Label()
        Me._lblDescripcion_22 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_23 = New System.Windows.Forms.Label()
        Me._lblDescripcion_23 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_24 = New System.Windows.Forms.Label()
        Me._lblDescripcion_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_25 = New System.Windows.Forms.Label()
        Me._lblDescripcion_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox5 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox6 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox4 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox2 = New System.Windows.Forms.GroupBox()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._lblEtiqueta_26 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._lblEtiqueta_11 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBeneficiarios = New System.Windows.Forms.ToolStripButton()
        Me.TSBPropietario = New System.Windows.Forms.ToolStripButton()
        Me.TSBFirmas = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.FrmTarjetaDeb, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FrmTarjetaDeb.SuspendLayout()
        CType(Me.grdBloqueos, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox5, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox5.SuspendLayout()
        CType(Me.UltraGroupBox6, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox6.SuspendLayout()
        CType(Me.UltraGroupBox4, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox4.SuspendLayout()
        CType(Me.UltraGroupBox3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox3.SuspendLayout()
        Me.GroupBox2.SuspendLayout()
        Me.GroupBox1.SuspendLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox2.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        CType(Me._lblEtiqueta_26, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._lblEtiqueta_26.SuspendLayout()
        CType(Me._lblEtiqueta_11, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._lblEtiqueta_11.SuspendLayout()
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
        Me.FrmTarjetaDeb.Controls.Add(Me._optTarjetaDebito_1)
        Me.FrmTarjetaDeb.Controls.Add(Me._optTarjetaDebito_0)
        Me.COBISStyleProvider.SetControlStyle(Me.FrmTarjetaDeb, "Default")
        Me.FrmTarjetaDeb.ForeColor = System.Drawing.Color.Navy
        Me.FrmTarjetaDeb.Location = New System.Drawing.Point(112, 119)
        Me.FrmTarjetaDeb.Name = "FrmTarjetaDeb"
        Me.FrmTarjetaDeb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrmTarjetaDeb.Size = New System.Drawing.Size(182, 23)
        Me.FrmTarjetaDeb.TabIndex = 15
        Me.FrmTarjetaDeb.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FrmTarjetaDeb, "")
        '
        '_optTarjetaDebito_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTarjetaDebito_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTarjetaDebito_1, False)
        Me._optTarjetaDebito_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTarjetaDebito_1, "Default")
        Me._optTarjetaDebito_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTarjetaDebito_1.Enabled = False
        Me._optTarjetaDebito_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._optTarjetaDebito_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._optTarjetaDebito_1.Location = New System.Drawing.Point(92, 1)
        Me._optTarjetaDebito_1.Name = "_optTarjetaDebito_1"
        Me.COBISResourceProvider.SetResourceID(Me._optTarjetaDebito_1, "5119")
        Me._optTarjetaDebito_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTarjetaDebito_1.Size = New System.Drawing.Size(53, 20)
        Me._optTarjetaDebito_1.TabIndex = 79
        Me._optTarjetaDebito_1.TabStop = True
        Me._optTarjetaDebito_1.Text = "*No"
        Me._optTarjetaDebito_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTarjetaDebito_1, "")
        '
        '_optTarjetaDebito_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTarjetaDebito_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTarjetaDebito_0, False)
        Me._optTarjetaDebito_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTarjetaDebito_0, "Default")
        Me._optTarjetaDebito_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTarjetaDebito_0.Enabled = False
        Me._optTarjetaDebito_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._optTarjetaDebito_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._optTarjetaDebito_0.Location = New System.Drawing.Point(28, 2)
        Me._optTarjetaDebito_0.Name = "_optTarjetaDebito_0"
        Me.COBISResourceProvider.SetResourceID(Me._optTarjetaDebito_0, "5118")
        Me._optTarjetaDebito_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTarjetaDebito_0.Size = New System.Drawing.Size(43, 17)
        Me._optTarjetaDebito_0.TabIndex = 78
        Me._optTarjetaDebito_0.TabStop = True
        Me._optTarjetaDebito_0.Text = "*Si"
        Me._optTarjetaDebito_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTarjetaDebito_0, "")
        '
        'grdBloqueos
        '
        Me.grdBloqueos._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdBloqueos, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdBloqueos, False)
        Me.grdBloqueos.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdBloqueos.Clip = ""
        Me.grdBloqueos.Col = CType(1, Short)
        Me.grdBloqueos.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdBloqueos.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdBloqueos.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdBloqueos, "Default")
        Me.grdBloqueos.CtlText = ""
        Me.grdBloqueos.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdBloqueos, True)
        Me.grdBloqueos.FixedCols = CType(1, Short)
        Me.grdBloqueos.FixedRows = CType(1, Short)
        Me.grdBloqueos.ForeColor = System.Drawing.Color.Black
        Me.grdBloqueos.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdBloqueos.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdBloqueos.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdBloqueos.HighLight = True
        Me.grdBloqueos.Location = New System.Drawing.Point(3, 16)
        Me.grdBloqueos.Name = "grdBloqueos"
        Me.grdBloqueos.Picture = Nothing
        Me.grdBloqueos.Row = CType(1, Short)
        Me.grdBloqueos.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdBloqueos.Size = New System.Drawing.Size(676, 54)
        Me.grdBloqueos.Sort = CType(2, Short)
        Me.grdBloqueos.TabIndex = 62
        Me.grdBloqueos.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdBloqueos, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(198, 9)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(139, 20)
        Me.mskCuenta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(-100, 39)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 1
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Propiet."
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'grdPropietarios
        '
        Me.grdPropietarios._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdPropietarios, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdPropietarios, False)
        Me.grdPropietarios.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdPropietarios.Clip = ""
        Me.grdPropietarios.Col = CType(1, Short)
        Me.grdPropietarios.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdPropietarios.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdPropietarios.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdPropietarios, "Default")
        Me.grdPropietarios.CtlText = ""
        Me.grdPropietarios.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdPropietarios, True)
        Me.grdPropietarios.FixedCols = CType(1, Short)
        Me.grdPropietarios.FixedRows = CType(1, Short)
        Me.grdPropietarios.ForeColor = System.Drawing.Color.Black
        Me.grdPropietarios.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdPropietarios.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdPropietarios.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdPropietarios.HighLight = True
        Me.grdPropietarios.Location = New System.Drawing.Point(3, 16)
        Me.grdPropietarios.Name = "grdPropietarios"
        Me.grdPropietarios.Picture = Nothing
        Me.grdPropietarios.Row = CType(1, Short)
        Me.grdPropietarios.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdPropietarios.Size = New System.Drawing.Size(676, 63)
        Me.grdPropietarios.Sort = CType(2, Short)
        Me.grdPropietarios.TabIndex = 6
        Me.grdPropietarios.TabStop = False
        Me.grdPropietarios.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdPropietarios, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-100, 232)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 3
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "&Transmitir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_cmdBoton_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_1, False)
        Me._cmdBoton_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_1, True)
        Me._cmdBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_1, Nothing)
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Location = New System.Drawing.Point(-100, 334)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 4
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Limpiar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-100, 385)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 5
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_cmdBoton_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_5, False)
        Me._cmdBoton_5.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_5, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_5, True)
        Me._cmdBoton_5.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_5, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_5, Nothing)
        Me._cmdBoton_5.Enabled = False
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Location = New System.Drawing.Point(-100, 39)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(59, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 66
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "Bene&ficiarios"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me._cmdBoton_5.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-100, 89)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(59, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 2
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Firma"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
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
        Me._cmdBoton_6.Location = New System.Drawing.Point(-100, 283)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 76
        Me._cmdBoton_6.TabStop = False
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
        Me.LblTarjetaDeb.Location = New System.Drawing.Point(6, 119)
        Me.LblTarjetaDeb.Name = "LblTarjetaDeb"
        Me.COBISResourceProvider.SetResourceID(Me.LblTarjetaDeb, "2426")
        Me.LblTarjetaDeb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblTarjetaDeb.Size = New System.Drawing.Size(100, 14)
        Me.LblTarjetaDeb.TabIndex = 80
        Me.LblTarjetaDeb.Text = "*Tarjeta Débito:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.LblTarjetaDeb, "")
        '
        'Label5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label5, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label5, False)
        Me.Label5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label5, "Default")
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me.Label5.ForeColor = System.Drawing.Color.Navy
        Me.Label5.Location = New System.Drawing.Point(8, 12)
        Me.Label5.Name = "Label5"
        Me.COBISResourceProvider.SetResourceID(Me.Label5, "2428")
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(63, 14)
        Me.Label5.TabIndex = 81
        Me.Label5.Text = "*Alianza:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label5, "")
        '
        'Lblalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Lblalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.Lblalianza, False)
        Me.Lblalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Lblalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.Lblalianza, "Default")
        Me.Lblalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.Lblalianza.Location = New System.Drawing.Point(94, 9)
        Me.Lblalianza.Name = "Lblalianza"
        Me.Lblalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Lblalianza.Size = New System.Drawing.Size(46, 20)
        Me.Lblalianza.TabIndex = 23
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Lblalianza, "")
        '
        'lbldesalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lbldesalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.lbldesalianza, False)
        Me.lbldesalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lbldesalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lbldesalianza, "Default")
        Me.lbldesalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.lbldesalianza.Location = New System.Drawing.Point(142, 9)
        Me.lbldesalianza.Name = "lbldesalianza"
        Me.lbldesalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lbldesalianza.Size = New System.Drawing.Size(522, 20)
        Me.lbldesalianza.TabIndex = 24
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lbldesalianza, "")
        '
        '_lblDescripcion_34
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_34, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_34, False)
        Me._lblDescripcion_34.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_34.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_34, "Default")
        Me._lblDescripcion_34.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_34.Location = New System.Drawing.Point(80, 123)
        Me._lblDescripcion_34.Name = "_lblDescripcion_34"
        Me._lblDescripcion_34.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_34.Size = New System.Drawing.Size(275, 20)
        Me._lblDescripcion_34.TabIndex = 13
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_34, "")
        '
        '_lblEtiqueta_29
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_29, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_29, False)
        Me._lblEtiqueta_29.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_29, "Default")
        Me._lblEtiqueta_29.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_29.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_29.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_29.Location = New System.Drawing.Point(6, 125)
        Me._lblEtiqueta_29.Name = "_lblEtiqueta_29"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_29, "5233")
        Me._lblEtiqueta_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_29.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_29.TabIndex = 74
        Me._lblEtiqueta_29.Text = "*Fideicomiso:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_29, "")
        '
        '_lblDescripcion_32
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_32, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_32, False)
        Me._lblDescripcion_32.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_32.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_32, "Default")
        Me._lblDescripcion_32.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_32.Location = New System.Drawing.Point(121, 23)
        Me._lblDescripcion_32.Name = "_lblDescripcion_32"
        Me._lblDescripcion_32.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_32.Size = New System.Drawing.Size(100, 20)
        Me._lblDescripcion_32.TabIndex = 73
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_32, "")
        '
        '_lblEtiqueta_28
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_28, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_28, False)
        Me._lblEtiqueta_28.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_28, "Default")
        Me._lblEtiqueta_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_28.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_28.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_28.Location = New System.Drawing.Point(8, 26)
        Me._lblEtiqueta_28.Name = "_lblEtiqueta_28"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_28, "5136")
        Me._lblEtiqueta_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_28.Size = New System.Drawing.Size(98, 14)
        Me._lblEtiqueta_28.TabIndex = 72
        Me._lblEtiqueta_28.Text = "*Personalizada:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_28, "")
        '
        '_lblDescripcion_33
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_33, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_33, False)
        Me._lblDescripcion_33.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_33.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_33, "Default")
        Me._lblDescripcion_33.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_33.Location = New System.Drawing.Point(280, 31)
        Me._lblDescripcion_33.Name = "_lblDescripcion_33"
        Me._lblDescripcion_33.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_33.Size = New System.Drawing.Size(75, 20)
        Me._lblDescripcion_33.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_33, "")
        '
        '_lblEtiqueta_31
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_31, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_31, False)
        Me._lblEtiqueta_31.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_31, "Default")
        Me._lblEtiqueta_31.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_31.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_31.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_31.Location = New System.Drawing.Point(225, 35)
        Me._lblEtiqueta_31.Name = "_lblEtiqueta_31"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_31, "500848")
        Me._lblEtiqueta_31.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_31.Size = New System.Drawing.Size(63, 14)
        Me._lblEtiqueta_31.TabIndex = 70
        Me._lblEtiqueta_31.Text = "*Num.Sol:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_31, "")
        '
        '_lblDescripcion_57
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_57, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_57, False)
        Me._lblDescripcion_57.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_57, "Default")
        Me._lblDescripcion_57.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_57.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Bold)
        Me._lblDescripcion_57.ForeColor = System.Drawing.Color.Navy
        Me._lblDescripcion_57.Location = New System.Drawing.Point(350, 12)
        Me._lblDescripcion_57.Name = "_lblDescripcion_57"
        Me.COBISResourceProvider.SetResourceID(Me._lblDescripcion_57, "500806")
        Me._lblDescripcion_57.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_57.Size = New System.Drawing.Size(163, 14)
        Me._lblDescripcion_57.TabIndex = 69
        Me._lblDescripcion_57.Text = "*CTA. EMBARGADA"
        Me._lblDescripcion_57.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me._lblDescripcion_57.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_57, "")
        '
        '_lblDescripcion_30
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_30, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_30, False)
        Me._lblDescripcion_30.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_30.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_30, "Default")
        Me._lblDescripcion_30.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_30.Location = New System.Drawing.Point(112, 99)
        Me._lblDescripcion_30.Name = "_lblDescripcion_30"
        Me._lblDescripcion_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_30.Size = New System.Drawing.Size(182, 20)
        Me._lblDescripcion_30.TabIndex = 12
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_30, "")
        '
        '_lblEtiqueta_27
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_27, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_27, False)
        Me._lblEtiqueta_27.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_27, "Default")
        Me._lblEtiqueta_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_27.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_27.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_27.Location = New System.Drawing.Point(6, 102)
        Me._lblEtiqueta_27.Name = "_lblEtiqueta_27"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_27, "5169")
        Me._lblEtiqueta_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_27.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_27.TabIndex = 67
        Me._lblEtiqueta_27.Text = "*Num. Libreta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_27, "")
        '
        '_lblEtiqueta_21
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_21, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_21, False)
        Me._lblEtiqueta_21.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_21, "Default")
        Me._lblEtiqueta_21.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_21.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_21.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_21.Location = New System.Drawing.Point(6, 79)
        Me._lblEtiqueta_21.Name = "_lblEtiqueta_21"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_21, "500850")
        Me._lblEtiqueta_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_21.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_21.TabIndex = 65
        Me._lblEtiqueta_21.Text = "*Fecha cierre:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_21, "")
        '
        '_lblDescripcion_31
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_31, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_31, False)
        Me._lblDescripcion_31.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_31.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_31, "Default")
        Me._lblDescripcion_31.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_31.Location = New System.Drawing.Point(112, 76)
        Me._lblDescripcion_31.Name = "_lblDescripcion_31"
        Me._lblDescripcion_31.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_31.Size = New System.Drawing.Size(182, 20)
        Me._lblDescripcion_31.TabIndex = 10
        Me._lblDescripcion_31.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_31, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(112, 6)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(30, 20)
        Me._lblDescripcion_1.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(6, 8)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "501909")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_1.TabIndex = 8
        Me._lblEtiqueta_1.Text = "*Dirección  E. C."
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(112, 53)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(182, 20)
        Me._lblDescripcion_3.TabIndex = 8
        Me._lblDescripcion_3.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(6, 56)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "500867")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_3.TabIndex = 10
        Me._lblEtiqueta_3.Text = "*Fecha apertura:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(112, 36)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(211, 20)
        Me._lblDescripcion_4.TabIndex = 19
        Me._lblDescripcion_4.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(6, 39)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "501910")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_4.TabIndex = 12
        Me._lblEtiqueta_4.Text = "*Próximo corte:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblDescripcion_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_5, False)
        Me._lblDescripcion_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_5, "Default")
        Me._lblDescripcion_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_5.Location = New System.Drawing.Point(109, 59)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(191, 20)
        Me._lblDescripcion_5.TabIndex = 22
        Me._lblDescripcion_5.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_5, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(6, 63)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "501911")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_5.TabIndex = 17
        Me._lblEtiqueta_5.Text = "*Ret. Remesas:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblDescripcion_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_6, False)
        Me._lblDescripcion_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_6, "Default")
        Me._lblDescripcion_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_6.Location = New System.Drawing.Point(112, 59)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(211, 20)
        Me._lblDescripcion_6.TabIndex = 21
        Me._lblDescripcion_6.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_6, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(6, 62)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "501912")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_7.TabIndex = 19
        Me._lblEtiqueta_7.Text = "*Ultimo mov.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblDescripcion_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_7, False)
        Me._lblDescripcion_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_7, "Default")
        Me._lblDescripcion_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_7.Location = New System.Drawing.Point(109, 36)
        Me._lblDescripcion_7.Name = "_lblDescripcion_7"
        Me._lblDescripcion_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_7.Size = New System.Drawing.Size(191, 20)
        Me._lblDescripcion_7.TabIndex = 20
        Me._lblDescripcion_7.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_7, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(6, 40)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "500864")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_8.TabIndex = 21
        Me._lblEtiqueta_8.Text = "*Ult. corte:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblDescripcion_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_10, False)
        Me._lblDescripcion_10.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_10.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_10, "Default")
        Me._lblDescripcion_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_10.Location = New System.Drawing.Point(80, 8)
        Me._lblDescripcion_10.Name = "_lblDescripcion_10"
        Me._lblDescripcion_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_10.Size = New System.Drawing.Size(139, 20)
        Me._lblDescripcion_10.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_10, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(6, 11)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "500163")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_9.TabIndex = 23
        Me._lblEtiqueta_9.Text = "*Cliente:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        '_lblDescripcion_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_11, False)
        Me._lblDescripcion_11.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_11.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_11, "Default")
        Me._lblDescripcion_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_11.Location = New System.Drawing.Point(280, 8)
        Me._lblDescripcion_11.Name = "_lblDescripcion_11"
        Me._lblDescripcion_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_11.Size = New System.Drawing.Size(75, 20)
        Me._lblDescripcion_11.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_11, "")
        '
        '_lblEtiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(223, 11)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "5202")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(65, 14)
        Me._lblEtiqueta_10.TabIndex = 25
        Me._lblEtiqueta_10.Text = "*Sucursal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        '_lblDescripcion_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_12, False)
        Me._lblDescripcion_12.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_12.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_12, "Default")
        Me._lblDescripcion_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_12.Location = New System.Drawing.Point(112, 7)
        Me._lblDescripcion_12.Name = "_lblDescripcion_12"
        Me._lblDescripcion_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_12.Size = New System.Drawing.Size(30, 20)
        Me._lblDescripcion_12.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_12, "")
        '
        '_lblEtiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_12, False)
        Me._lblEtiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_12, "Default")
        Me._lblEtiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_12.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_12.Location = New System.Drawing.Point(6, 10)
        Me._lblEtiqueta_12.Name = "_lblEtiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_12, "5067")
        Me._lblEtiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_12.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_12.TabIndex = 27
        Me._lblEtiqueta_12.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_12, "")
        '
        '_lblDescripcion_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_13, False)
        Me._lblDescripcion_13.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_13.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_13, "Default")
        Me._lblDescripcion_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_13.Location = New System.Drawing.Point(145, 7)
        Me._lblDescripcion_13.Name = "_lblDescripcion_13"
        Me._lblDescripcion_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_13.Size = New System.Drawing.Size(149, 20)
        Me._lblDescripcion_13.TabIndex = 28
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_13, "")
        '
        '_lblDescripcion_18
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_18, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_18, False)
        Me._lblDescripcion_18.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_18.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_18, "Default")
        Me._lblDescripcion_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_18.Location = New System.Drawing.Point(112, 122)
        Me._lblDescripcion_18.Name = "_lblDescripcion_18"
        Me._lblDescripcion_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_18.Size = New System.Drawing.Size(30, 20)
        Me._lblDescripcion_18.TabIndex = 14
        Me._lblDescripcion_18.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_18, "")
        '
        '_lblEtiqueta_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_13, False)
        Me._lblEtiqueta_13.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_13, "Default")
        Me._lblEtiqueta_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_13.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_13.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_13.Location = New System.Drawing.Point(6, 119)
        Me._lblEtiqueta_13.Name = "_lblEtiqueta_13"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_13, "500847")
        Me._lblEtiqueta_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_13.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_13.TabIndex = 30
        Me._lblEtiqueta_13.Text = "*Tipo deft."
        Me._lblEtiqueta_13.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_13, "")
        '
        '_lblDescripcion_19
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_19, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_19, False)
        Me._lblDescripcion_19.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_19.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_19, "Default")
        Me._lblDescripcion_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_19.Location = New System.Drawing.Point(145, 122)
        Me._lblDescripcion_19.Name = "_lblDescripcion_19"
        Me._lblDescripcion_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_19.Size = New System.Drawing.Size(149, 20)
        Me._lblDescripcion_19.TabIndex = 31
        Me._lblDescripcion_19.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_19, "")
        '
        '_lblDescripcion_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_16, False)
        Me._lblDescripcion_16.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_16.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_16, "Default")
        Me._lblDescripcion_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_16.Location = New System.Drawing.Point(80, 100)
        Me._lblDescripcion_16.Name = "_lblDescripcion_16"
        Me._lblDescripcion_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_16.Size = New System.Drawing.Size(30, 20)
        Me._lblDescripcion_16.TabIndex = 11
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_16, "")
        '
        '_lblEtiqueta_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_14, False)
        Me._lblEtiqueta_14.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_14, "Default")
        Me._lblEtiqueta_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_14.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_14.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_14.Location = New System.Drawing.Point(6, 103)
        Me._lblEtiqueta_14.Name = "_lblEtiqueta_14"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_14, "501913")
        Me._lblEtiqueta_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_14.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_14.TabIndex = 33
        Me._lblEtiqueta_14.Text = "*Promedio:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_14, "")
        '
        '_lblDescripcion_17
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_17, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_17, False)
        Me._lblDescripcion_17.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_17.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_17, "Default")
        Me._lblDescripcion_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_17.Location = New System.Drawing.Point(113, 100)
        Me._lblDescripcion_17.Name = "_lblDescripcion_17"
        Me._lblDescripcion_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_17.Size = New System.Drawing.Size(242, 20)
        Me._lblDescripcion_17.TabIndex = 34
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_17, "")
        '
        '_lblDescripcion_20
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_20, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_20, False)
        Me._lblDescripcion_20.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_20.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_20, "Default")
        Me._lblDescripcion_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_20.Location = New System.Drawing.Point(121, 23)
        Me._lblDescripcion_20.Name = "_lblDescripcion_20"
        Me._lblDescripcion_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_20.Size = New System.Drawing.Size(100, 20)
        Me._lblDescripcion_20.TabIndex = 35
        Me._lblDescripcion_20.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_20, "")
        '
        '_lblEtiqueta_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_15, False)
        Me._lblEtiqueta_15.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_15, "Default")
        Me._lblEtiqueta_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_15.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_15.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_15.Location = New System.Drawing.Point(8, 27)
        Me._lblEtiqueta_15.Name = "_lblEtiqueta_15"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_15, "500863")
        Me._lblEtiqueta_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_15.Size = New System.Drawing.Size(98, 14)
        Me._lblEtiqueta_15.TabIndex = 36
        Me._lblEtiqueta_15.Text = "*Descrip. default:"
        Me._lblEtiqueta_15.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_15, "")
        '
        '_lblDescripcion_21
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_21, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_21, False)
        Me._lblDescripcion_21.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_21.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_21, "Default")
        Me._lblDescripcion_21.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_21.Location = New System.Drawing.Point(121, 23)
        Me._lblDescripcion_21.Name = "_lblDescripcion_21"
        Me._lblDescripcion_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_21.Size = New System.Drawing.Size(100, 20)
        Me._lblDescripcion_21.TabIndex = 37
        Me._lblDescripcion_21.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_21, "")
        '
        '_lblDescripcion_24
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_24, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_24, False)
        Me._lblDescripcion_24.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_24.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_24, "Default")
        Me._lblDescripcion_24.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_24.Location = New System.Drawing.Point(80, 31)
        Me._lblDescripcion_24.Name = "_lblDescripcion_24"
        Me._lblDescripcion_24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_24.Size = New System.Drawing.Size(30, 20)
        Me._lblDescripcion_24.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_24, "")
        '
        '_lblEtiqueta_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_16, False)
        Me._lblEtiqueta_16.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_16, "Default")
        Me._lblEtiqueta_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_16.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_16.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_16.Location = New System.Drawing.Point(6, 35)
        Me._lblEtiqueta_16.Name = "_lblEtiqueta_16"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_16, "5209")
        Me._lblEtiqueta_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_16.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_16.TabIndex = 39
        Me._lblEtiqueta_16.Text = "*Moneda:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_16, "")
        '
        '_lblDescripcion_25
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_25, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_25, False)
        Me._lblDescripcion_25.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_25.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_25, "Default")
        Me._lblDescripcion_25.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_25.Location = New System.Drawing.Point(113, 31)
        Me._lblDescripcion_25.Name = "_lblDescripcion_25"
        Me._lblDescripcion_25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_25.Size = New System.Drawing.Size(106, 20)
        Me._lblDescripcion_25.TabIndex = 40
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_25, "")
        '
        '_lblDescripcion_26
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_26, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_26, False)
        Me._lblDescripcion_26.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_26.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_26, "Default")
        Me._lblDescripcion_26.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_26.Location = New System.Drawing.Point(80, 54)
        Me._lblDescripcion_26.Name = "_lblDescripcion_26"
        Me._lblDescripcion_26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_26.Size = New System.Drawing.Size(30, 20)
        Me._lblDescripcion_26.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_26, "")
        '
        '_lblEtiqueta_17
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_17, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_17, False)
        Me._lblEtiqueta_17.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_17, "Default")
        Me._lblEtiqueta_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_17.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_17.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_17.Location = New System.Drawing.Point(6, 58)
        Me._lblEtiqueta_17.Name = "_lblEtiqueta_17"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_17, "500862")
        Me._lblEtiqueta_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_17.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_17.TabIndex = 42
        Me._lblEtiqueta_17.Text = "*Oficial:"
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
        Me._lblDescripcion_27.Location = New System.Drawing.Point(113, 54)
        Me._lblDescripcion_27.Name = "_lblDescripcion_27"
        Me._lblDescripcion_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_27.Size = New System.Drawing.Size(242, 20)
        Me._lblDescripcion_27.TabIndex = 43
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_27, "")
        '
        '_lblDescripcion_28
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_28, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_28, False)
        Me._lblDescripcion_28.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_28.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_28, "Default")
        Me._lblDescripcion_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_28.Location = New System.Drawing.Point(112, 30)
        Me._lblDescripcion_28.Name = "_lblDescripcion_28"
        Me._lblDescripcion_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_28.Size = New System.Drawing.Size(30, 20)
        Me._lblDescripcion_28.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_28, "")
        '
        '_lblEtiqueta_18
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_18, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_18, False)
        Me._lblEtiqueta_18.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_18, "Default")
        Me._lblEtiqueta_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_18.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_18.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_18.Location = New System.Drawing.Point(6, 33)
        Me._lblEtiqueta_18.Name = "_lblEtiqueta_18"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_18, "500861")
        Me._lblEtiqueta_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_18.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_18.TabIndex = 45
        Me._lblEtiqueta_18.Text = "*Ciclo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_18, "")
        '
        '_lblDescripcion_29
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_29, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_29, False)
        Me._lblDescripcion_29.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_29.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_29, "Default")
        Me._lblDescripcion_29.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_29.Location = New System.Drawing.Point(145, 30)
        Me._lblDescripcion_29.Name = "_lblDescripcion_29"
        Me._lblDescripcion_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_29.Size = New System.Drawing.Size(149, 20)
        Me._lblDescripcion_29.TabIndex = 46
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_29, "")
        '
        '_lblDescripcion_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_14, False)
        Me._lblDescripcion_14.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_14.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_14, "Default")
        Me._lblDescripcion_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_14.Location = New System.Drawing.Point(80, 77)
        Me._lblDescripcion_14.Name = "_lblDescripcion_14"
        Me._lblDescripcion_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_14.Size = New System.Drawing.Size(30, 20)
        Me._lblDescripcion_14.TabIndex = 9
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_14, "")
        '
        '_lblEtiqueta_22
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_22, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_22, False)
        Me._lblEtiqueta_22.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_22, "Default")
        Me._lblEtiqueta_22.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_22.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_22.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_22.Location = New System.Drawing.Point(6, 81)
        Me._lblEtiqueta_22.Name = "_lblEtiqueta_22"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_22, "500786")
        Me._lblEtiqueta_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_22.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_22.TabIndex = 54
        Me._lblEtiqueta_22.Text = "*Categoría:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_22, "")
        '
        '_lblDescripcion_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_15, False)
        Me._lblDescripcion_15.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_15.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_15, "Default")
        Me._lblDescripcion_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_15.Location = New System.Drawing.Point(113, 77)
        Me._lblDescripcion_15.Name = "_lblDescripcion_15"
        Me._lblDescripcion_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_15.Size = New System.Drawing.Size(242, 20)
        Me._lblDescripcion_15.TabIndex = 55
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_15, "")
        '
        '_lblDescripcion_22
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_22, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_22, False)
        Me._lblDescripcion_22.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_22.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_22, "Default")
        Me._lblDescripcion_22.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_22.Location = New System.Drawing.Point(121, 23)
        Me._lblDescripcion_22.Name = "_lblDescripcion_22"
        Me._lblDescripcion_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_22.Size = New System.Drawing.Size(100, 20)
        Me._lblDescripcion_22.TabIndex = 56
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
        Me._lblEtiqueta_23.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_23.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_23.Location = New System.Drawing.Point(8, 26)
        Me._lblEtiqueta_23.Name = "_lblEtiqueta_23"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_23, "501914")
        Me._lblEtiqueta_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_23.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_23.TabIndex = 48
        Me._lblEtiqueta_23.Text = "*Rol del cliente:"
        Me._lblEtiqueta_23.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_23, "")
        '
        '_lblDescripcion_23
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_23, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_23, False)
        Me._lblDescripcion_23.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_23.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_23, "Default")
        Me._lblDescripcion_23.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_23.Location = New System.Drawing.Point(121, 23)
        Me._lblDescripcion_23.Name = "_lblDescripcion_23"
        Me._lblDescripcion_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_23.Size = New System.Drawing.Size(100, 20)
        Me._lblDescripcion_23.TabIndex = 16
        Me._lblDescripcion_23.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_23, "")
        '
        '_lblEtiqueta_24
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_24, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_24, False)
        Me._lblEtiqueta_24.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_24, "Default")
        Me._lblEtiqueta_24.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_24.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_24.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_24.Location = New System.Drawing.Point(6, 16)
        Me._lblEtiqueta_24.Name = "_lblEtiqueta_24"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_24, "500859")
        Me._lblEtiqueta_24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_24.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_24.TabIndex = 50
        Me._lblEtiqueta_24.Text = "*De ayer:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_24, "")
        '
        '_lblDescripcion_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_8, False)
        Me._lblDescripcion_8.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_8.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_8, "Default")
        Me._lblDescripcion_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_8.Location = New System.Drawing.Point(109, 13)
        Me._lblDescripcion_8.Name = "_lblDescripcion_8"
        Me._lblDescripcion_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_8.Size = New System.Drawing.Size(191, 20)
        Me._lblDescripcion_8.TabIndex = 18
        Me._lblDescripcion_8.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_8, "")
        '
        '_lblEtiqueta_25
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_25, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_25, False)
        Me._lblEtiqueta_25.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_25, "Default")
        Me._lblEtiqueta_25.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_25.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_25.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_25.Location = New System.Drawing.Point(6, 16)
        Me._lblEtiqueta_25.Name = "_lblEtiqueta_25"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_25, "500858")
        Me._lblEtiqueta_25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_25.Size = New System.Drawing.Size(100, 14)
        Me._lblEtiqueta_25.TabIndex = 52
        Me._lblEtiqueta_25.Text = "*Ultimo corte:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_25, "")
        '
        '_lblDescripcion_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_9, False)
        Me._lblDescripcion_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_9, "Default")
        Me._lblDescripcion_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_9.Location = New System.Drawing.Point(112, 13)
        Me._lblDescripcion_9.Name = "_lblDescripcion_9"
        Me._lblDescripcion_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_9.Size = New System.Drawing.Size(211, 20)
        Me._lblDescripcion_9.TabIndex = 17
        Me._lblDescripcion_9.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_9, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(148, 6)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(518, 20)
        Me._lblDescripcion_2.TabIndex = 59
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 31)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500108")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(163, 14)
        Me._lblEtiqueta_6.TabIndex = 14
        Me._lblEtiqueta_6.Text = "*Nombre de la cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 9)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501853")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(163, 14)
        Me._lblEtiqueta_0.TabIndex = 15
        Me._lblEtiqueta_0.Text = "*No. de cuenta de ahorros:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(198, 31)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(469, 19)
        Me._lblDescripcion_0.TabIndex = 16
        Me._lblDescripcion_0.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox5)
        Me.PFormas.Controls.Add(Me.UltraGroupBox6)
        Me.PFormas.Controls.Add(Me.UltraGroupBox4)
        Me.PFormas.Controls.Add(Me.UltraGroupBox3)
        Me.PFormas.Controls.Add(Me.UltraGroupBox2)
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_26)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_11)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me.mskCuenta)
        Me.PFormas.Controls.Add(Me._lblDescripcion_57)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(701, 614)
        Me.PFormas.TabIndex = 84
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox5, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox5, False)
        Me.UltraGroupBox5.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_12)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_28)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_13)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_29)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_3)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_30)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_31)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_13)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_21)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_27)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_3)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_18)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_12)
        Me.UltraGroupBox5.Controls.Add(Me.LblTarjetaDeb)
        Me.UltraGroupBox5.Controls.Add(Me.FrmTarjetaDeb)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_19)
        Me.UltraGroupBox5.Controls.Add(Me._lblDescripcion_18)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox5, "Default")
        Me.UltraGroupBox5.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox5.Location = New System.Drawing.Point(380, 174)
        Me.UltraGroupBox5.Name = "UltraGroupBox5"
        Me.UltraGroupBox5.Size = New System.Drawing.Size(312, 152)
        Me.UltraGroupBox5.TabIndex = 86
        Me.UltraGroupBox5.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox5, "")
        '
        'UltraGroupBox6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox6, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox6, False)
        Me.UltraGroupBox6.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_34)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_10)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_26)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_24)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_14)
        Me.UltraGroupBox6.Controls.Add(Me._lblEtiqueta_17)
        Me.UltraGroupBox6.Controls.Add(Me._lblEtiqueta_9)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_27)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_33)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_11)
        Me.UltraGroupBox6.Controls.Add(Me._lblEtiqueta_10)
        Me.UltraGroupBox6.Controls.Add(Me._lblEtiqueta_31)
        Me.UltraGroupBox6.Controls.Add(Me._lblEtiqueta_29)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_15)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_25)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_16)
        Me.UltraGroupBox6.Controls.Add(Me._lblEtiqueta_14)
        Me.UltraGroupBox6.Controls.Add(Me._lblEtiqueta_16)
        Me.UltraGroupBox6.Controls.Add(Me._lblEtiqueta_22)
        Me.UltraGroupBox6.Controls.Add(Me._lblDescripcion_17)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox6, "Default")
        Me.UltraGroupBox6.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox6.Location = New System.Drawing.Point(10, 174)
        Me.UltraGroupBox6.Name = "UltraGroupBox6"
        Me.UltraGroupBox6.Size = New System.Drawing.Size(364, 152)
        Me.UltraGroupBox6.TabIndex = 87
        Me.UltraGroupBox6.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox6, "")
        '
        'UltraGroupBox4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox4, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox4, False)
        Me.UltraGroupBox4.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox4.Controls.Add(Me.lbldesalianza)
        Me.UltraGroupBox4.Controls.Add(Me.Lblalianza)
        Me.UltraGroupBox4.Controls.Add(Me.Label5)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox4, "Default")
        Me.UltraGroupBox4.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox4.Location = New System.Drawing.Point(10, 570)
        Me.UltraGroupBox4.Name = "UltraGroupBox4"
        Me.UltraGroupBox4.Size = New System.Drawing.Size(682, 38)
        Me.UltraGroupBox4.TabIndex = 89
        Me.UltraGroupBox4.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox4, "")
        '
        'UltraGroupBox3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox3, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox3, False)
        Me.UltraGroupBox3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox3.Controls.Add(Me.GroupBox2)
        Me.UltraGroupBox3.Controls.Add(Me.GroupBox1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox3, "Default")
        Me.UltraGroupBox3.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox3.Location = New System.Drawing.Point(10, 382)
        Me.UltraGroupBox3.Name = "UltraGroupBox3"
        Me.UltraGroupBox3.Size = New System.Drawing.Size(682, 105)
        Me.UltraGroupBox3.TabIndex = 88
        Me.UltraGroupBox3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox3, "")
        '
        'GroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox2, False)
        Me.GroupBox2.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox2.Controls.Add(Me._lblEtiqueta_24)
        Me.GroupBox2.Controls.Add(Me._lblDescripcion_7)
        Me.GroupBox2.Controls.Add(Me._lblDescripcion_8)
        Me.GroupBox2.Controls.Add(Me._lblEtiqueta_8)
        Me.GroupBox2.Controls.Add(Me._lblDescripcion_5)
        Me.GroupBox2.Controls.Add(Me._lblEtiqueta_5)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox2, "Default")
        Me.GroupBox2.Location = New System.Drawing.Point(353, 5)
        Me.GroupBox2.Name = "GroupBox2"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox2, "2427")
        Me.GroupBox2.Size = New System.Drawing.Size(323, 87)
        Me.GroupBox2.TabIndex = 60
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "*SALDOS"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox2, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_25)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_9)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_4)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_4)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_7)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_6)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Location = New System.Drawing.Point(9, 5)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "500855")
        Me.GroupBox1.Size = New System.Drawing.Size(330, 87)
        Me.GroupBox1.TabIndex = 59
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "*FECHAS"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'UltraGroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_28)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_23)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_32)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_20)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_22)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_21)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_23)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_15)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox2.Location = New System.Drawing.Point(10, 327)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.COBISResourceProvider.SetResourceID(Me.UltraGroupBox2, "500856")
        Me.UltraGroupBox2.Size = New System.Drawing.Size(682, 52)
        Me.UltraGroupBox2.TabIndex = 87
        Me.UltraGroupBox2.Text = "*PERSONALIZACION"
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_1)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 139)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(682, 33)
        Me.UltraGroupBox1.TabIndex = 86
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        '_lblEtiqueta_26
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_26, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_26, False)
        Me._lblEtiqueta_26.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblEtiqueta_26.Controls.Add(Me.grdBloqueos)
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_26, "Default")
        Me._lblEtiqueta_26.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Bold)
        Me._lblEtiqueta_26.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_26.Location = New System.Drawing.Point(10, 493)
        Me._lblEtiqueta_26.Name = "_lblEtiqueta_26"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_26, "500849")
        Me._lblEtiqueta_26.Size = New System.Drawing.Size(682, 73)
        Me._lblEtiqueta_26.TabIndex = 85
        Me._lblEtiqueta_26.Text = "*BLOQUEOS:"
        Me._lblEtiqueta_26.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_26, "")
        '
        '_lblEtiqueta_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_11, False)
        Me._lblEtiqueta_11.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblEtiqueta_11.Controls.Add(Me.grdPropietarios)
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_11, "Default")
        Me._lblEtiqueta_11.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Bold)
        Me._lblEtiqueta_11.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_11.Location = New System.Drawing.Point(10, 55)
        Me._lblEtiqueta_11.Name = "_lblEtiqueta_11"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_11, "2425")
        Me._lblEtiqueta_11.Size = New System.Drawing.Size(682, 82)
        Me._lblEtiqueta_11.TabIndex = 84
        Me._lblEtiqueta_11.Text = "*Propietario"
        Me._lblEtiqueta_11.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_11, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBeneficiarios, Me.TSBPropietario, Me.TSBFirmas, Me.TSBTransmitir, Me.TSBSiguientes, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(721, 25)
        Me.TSBotones.TabIndex = 85
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBeneficiarios
        '
        Me.TSBBeneficiarios.ForeColor = System.Drawing.Color.Black
        Me.TSBBeneficiarios.Image = CType(resources.GetObject("TSBBeneficiarios.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBeneficiarios, "2067")
        Me.TSBBeneficiarios.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBeneficiarios.Name = "TSBBeneficiarios"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBeneficiarios, "2442")
        Me.TSBBeneficiarios.Size = New System.Drawing.Size(99, 22)
        Me.TSBBeneficiarios.Text = "*&Beneficiarios"
        '
        'TSBPropietario
        '
        Me.TSBPropietario.ForeColor = System.Drawing.Color.Black
        Me.TSBPropietario.Image = CType(resources.GetObject("TSBPropietario.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBPropietario, "2032")
        Me.TSBPropietario.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBPropietario.Name = "TSBPropietario"
        Me.COBISResourceProvider.SetResourceID(Me.TSBPropietario, "2443")
        Me.TSBPropietario.Size = New System.Drawing.Size(85, 22)
        Me.TSBPropietario.Text = "&Propietario"
        '
        'TSBFirmas
        '
        Me.TSBFirmas.ForeColor = System.Drawing.Color.Black
        Me.TSBFirmas.Image = CType(resources.GetObject("TSBFirmas.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBFirmas, "2027")
        Me.TSBFirmas.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBFirmas.Name = "TSBFirmas"
        Me.COBISResourceProvider.SetResourceID(Me.TSBFirmas, "2441")
        Me.TSBFirmas.Size = New System.Drawing.Size(62, 22)
        Me.TSBFirmas.Text = "&Firmas"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(81, 22)
        Me.TSBTransmitir.Text = "&Transmitir"
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2020")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "2040")
        Me.TSBSiguientes.Size = New System.Drawing.Size(81, 22)
        Me.TSBSiguientes.Text = "&Siguientes"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(64, 22)
        Me.TSBLimpiar.Text = "&limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(49, 22)
        Me.TSBSalir.Text = "&Salir"
        '
        'FTran235Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBoton_3)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.Controls.Add(Me._cmdBoton_5)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._cmdBoton_6)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(8, 90)
        Me.Name = "FTran235Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(721, 670)
        Me.Tag = "3866"
        Me.Text = "*Consulta no Monetaria a la Cuenta de Ahorros"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.FrmTarjetaDeb, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FrmTarjetaDeb.ResumeLayout(False)
        CType(Me.grdBloqueos, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.UltraGroupBox5, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox5.ResumeLayout(False)
        CType(Me.UltraGroupBox6, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox6.ResumeLayout(False)
        CType(Me.UltraGroupBox4, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox4.ResumeLayout(False)
        CType(Me.UltraGroupBox3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox3.ResumeLayout(False)
        Me.GroupBox2.ResumeLayout(False)
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox2.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        CType(Me._lblEtiqueta_26, System.ComponentModel.ISupportInitialize).EndInit()
        Me._lblEtiqueta_26.ResumeLayout(False)
        CType(Me._lblEtiqueta_11, System.ComponentModel.ISupportInitialize).EndInit()
        Me._lblEtiqueta_11.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptTarjetaDebito()
        Me.optTarjetaDebito(1) = _optTarjetaDebito_1
        Me.optTarjetaDebito(0) = _optTarjetaDebito_0
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(29) = _lblEtiqueta_29
        Me.lblEtiqueta(28) = _lblEtiqueta_28
        Me.lblEtiqueta(31) = _lblEtiqueta_31
        Me.lblEtiqueta(27) = _lblEtiqueta_27
        Me.lblEtiqueta(21) = _lblEtiqueta_21
        'Me.lblEtiqueta(26).Text = _lblEtiqueta_26x.Text
        'Me.lblEtiqueta(20) = _lblEtiqueta_20
        'Me.lblEtiqueta(19) = _lblEtiqueta_19
        'Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(12) = _lblEtiqueta_12
        Me.lblEtiqueta(13) = _lblEtiqueta_13
        Me.lblEtiqueta(14) = _lblEtiqueta_14
        Me.lblEtiqueta(15) = _lblEtiqueta_15
        Me.lblEtiqueta(16) = _lblEtiqueta_16
        Me.lblEtiqueta(17) = _lblEtiqueta_17
        Me.lblEtiqueta(18) = _lblEtiqueta_18
        Me.lblEtiqueta(22) = _lblEtiqueta_22
        Me.lblEtiqueta(23) = _lblEtiqueta_23
        Me.lblEtiqueta(24) = _lblEtiqueta_24
        Me.lblEtiqueta(25) = _lblEtiqueta_25
        'Me.lblEtiqueta(11) = _lblEtiqueta_11
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(34) = _lblDescripcion_34
        Me.lblDescripcion(32) = _lblDescripcion_32
        Me.lblDescripcion(33) = _lblDescripcion_33
        Me.lblDescripcion(57) = _lblDescripcion_57
        Me.lblDescripcion(30) = _lblDescripcion_30
        Me.lblDescripcion(31) = _lblDescripcion_31
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(5) = _lblDescripcion_5
        Me.lblDescripcion(6) = _lblDescripcion_6
        Me.lblDescripcion(7) = _lblDescripcion_7
        Me.lblDescripcion(10) = _lblDescripcion_10
        Me.lblDescripcion(11) = _lblDescripcion_11
        Me.lblDescripcion(12) = _lblDescripcion_12
        Me.lblDescripcion(13) = _lblDescripcion_13
        Me.lblDescripcion(18) = _lblDescripcion_18
        Me.lblDescripcion(19) = _lblDescripcion_19
        Me.lblDescripcion(16) = _lblDescripcion_16
        Me.lblDescripcion(17) = _lblDescripcion_17
        Me.lblDescripcion(20) = _lblDescripcion_20
        Me.lblDescripcion(21) = _lblDescripcion_21
        Me.lblDescripcion(24) = _lblDescripcion_24
        Me.lblDescripcion(25) = _lblDescripcion_25
        Me.lblDescripcion(26) = _lblDescripcion_26
        Me.lblDescripcion(27) = _lblDescripcion_27
        Me.lblDescripcion(28) = _lblDescripcion_28
        Me.lblDescripcion(29) = _lblDescripcion_29
        Me.lblDescripcion(14) = _lblDescripcion_14
        Me.lblDescripcion(15) = _lblDescripcion_15
        Me.lblDescripcion(22) = _lblDescripcion_22
        Me.lblDescripcion(23) = _lblDescripcion_23
        Me.lblDescripcion(8) = _lblDescripcion_8
        Me.lblDescripcion(9) = _lblDescripcion_9
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(6) = _cmdBoton_6
    End Sub

    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBPropietario As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBFirmas As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBBeneficiarios As System.Windows.Forms.ToolStripButton
    Friend WithEvents _lblEtiqueta_11 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents _lblEtiqueta_26 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox4 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox3 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox5 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox6 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
#End Region
End Class


