Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class FTranUpGMFClass
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializetxtCampo()
        Initializelbletiqueta()
        InitializelblDescripcion()
        InitializecmdBoton()
        'InitializeLine1()
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
    Private WithEvents _txtCampo_12 As System.Windows.Forms.TextBox
    Public WithEvents cmbTipo As System.Windows.Forms.ComboBox
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Public WithEvents lblFecDesm As System.Windows.Forms.Label
    Public WithEvents lblFecMarca As System.Windows.Forms.Label
    Public WithEvents lblOfiDesmarca As System.Windows.Forms.Label
    Public WithEvents lblOfiMarca As System.Windows.Forms.Label
    Public WithEvents txtdescripcion As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_3 As System.Windows.Forms.Label
    Public WithEvents lblOficinaDesm As System.Windows.Forms.Label
    Public WithEvents lblOficinaMarca As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_18 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_14 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_20 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_19 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_0 As System.Windows.Forms.Label
    Public Line1(3) As System.Windows.Forms.Label
    Public cmdBoton(6) As System.Windows.Forms.Button
    Public lblDescripcion(14) As System.Windows.Forms.Label
    Public lbletiqueta(20) As System.Windows.Forms.Label
    Public txtCampo(12) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTranUpGMFClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtCampo_12 = New System.Windows.Forms.TextBox()
        Me.cmbTipo = New System.Windows.Forms.ComboBox()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me.lblFecDesm = New System.Windows.Forms.Label()
        Me.lblFecMarca = New System.Windows.Forms.Label()
        Me.lblOfiDesmarca = New System.Windows.Forms.Label()
        Me.lblOfiMarca = New System.Windows.Forms.Label()
        Me.txtdescripcion = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lbletiqueta_4 = New System.Windows.Forms.Label()
        Me._lbletiqueta_7 = New System.Windows.Forms.Label()
        Me._lbletiqueta_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lbletiqueta_3 = New System.Windows.Forms.Label()
        Me.lblOficinaDesm = New System.Windows.Forms.Label()
        Me.lblOficinaMarca = New System.Windows.Forms.Label()
        Me._lbletiqueta_2 = New System.Windows.Forms.Label()
        Me._lbletiqueta_18 = New System.Windows.Forms.Label()
        Me._lblDescripcion_14 = New System.Windows.Forms.Label()
        Me._lbletiqueta_20 = New System.Windows.Forms.Label()
        Me._lbletiqueta_19 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lbletiqueta_6 = New System.Windows.Forms.Label()
        Me._lbletiqueta_1 = New System.Windows.Forms.Label()
        Me._lbletiqueta_0 = New System.Windows.Forms.Label()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBRtaCifin = New System.Windows.Forms.ToolStripButton()
        Me.TSBMarcar = New System.Windows.Forms.ToolStripButton()
        Me.TSBDesmarcar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        CType(Me.GroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox2.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
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
        '_txtCampo_12
        '
        Me._txtCampo_12.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_12, False)
        Me._txtCampo_12.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_12, "Default")
        Me._txtCampo_12.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_12.Location = New System.Drawing.Point(139, 66)
        Me._txtCampo_12.MaxLength = 2
        Me._txtCampo_12.Name = "_txtCampo_12"
        Me._txtCampo_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_12.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_12.TabIndex = 8
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_12, "")
        '
        'cmbTipo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbTipo, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbTipo, False)
        Me.cmbTipo.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbTipo, "Default")
        Me.cmbTipo.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbTipo.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbTipo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbTipo.Location = New System.Drawing.Point(138, 14)
        Me.cmbTipo.Name = "cmbTipo"
        Me.cmbTipo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbTipo.Size = New System.Drawing.Size(150, 21)
        Me.cmbTipo.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbTipo, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-615, 59)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(66, 52)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 4
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Rta CIFIN"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-615, 218)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(66, 52)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 7
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Limpiar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(-615, 271)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(66, 52)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 8
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Salir"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(418, 17)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(150, 20)
        Me.mskCuenta.TabIndex = 1
        Me.mskCuenta.Tag = "1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-615, 6)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(66, 52)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 2
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Buscar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Location = New System.Drawing.Point(-615, 112)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(66, 52)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 5
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Tag = "4142"
        Me._cmdBoton_5.Text = "*&Marcar"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_6.Location = New System.Drawing.Point(-615, 165)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(66, 52)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 6
        Me._cmdBoton_6.TabStop = False
        Me._cmdBoton_6.Tag = "4148"
        Me._cmdBoton_6.Text = "*&Desmarcar"
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
        '
        'lblFecDesm
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblFecDesm, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblFecDesm, False)
        Me.lblFecDesm.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblFecDesm.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblFecDesm, "Default")
        Me.lblFecDesm.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFecDesm.Location = New System.Drawing.Point(139, 19)
        Me.lblFecDesm.Name = "lblFecDesm"
        Me.lblFecDesm.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFecDesm.Size = New System.Drawing.Size(150, 19)
        Me.lblFecDesm.TabIndex = 10
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblFecDesm, "")
        '
        'lblFecMarca
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblFecMarca, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblFecMarca, False)
        Me.lblFecMarca.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblFecMarca.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblFecMarca, "Default")
        Me.lblFecMarca.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFecMarca.Location = New System.Drawing.Point(139, 21)
        Me.lblFecMarca.Name = "lblFecMarca"
        Me.lblFecMarca.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFecMarca.Size = New System.Drawing.Size(150, 19)
        Me.lblFecMarca.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblFecMarca, "")
        '
        'lblOfiDesmarca
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblOfiDesmarca, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblOfiDesmarca, False)
        Me.lblOfiDesmarca.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblOfiDesmarca.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblOfiDesmarca, "Default")
        Me.lblOfiDesmarca.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblOfiDesmarca.Location = New System.Drawing.Point(139, 42)
        Me.lblOfiDesmarca.Name = "lblOfiDesmarca"
        Me.lblOfiDesmarca.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblOfiDesmarca.Size = New System.Drawing.Size(45, 19)
        Me.lblOfiDesmarca.TabIndex = 12
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblOfiDesmarca, "")
        '
        'lblOfiMarca
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblOfiMarca, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblOfiMarca, False)
        Me.lblOfiMarca.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblOfiMarca.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblOfiMarca, "Default")
        Me.lblOfiMarca.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblOfiMarca.Location = New System.Drawing.Point(139, 43)
        Me.lblOfiMarca.Name = "lblOfiMarca"
        Me.lblOfiMarca.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblOfiMarca.Size = New System.Drawing.Size(45, 19)
        Me.lblOfiMarca.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblOfiMarca, "")
        '
        'txtdescripcion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtdescripcion, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtdescripcion, False)
        Me.txtdescripcion.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.txtdescripcion.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.txtdescripcion, "Default")
        Me.txtdescripcion.Cursor = System.Windows.Forms.Cursors.Default
        Me.txtdescripcion.Location = New System.Drawing.Point(187, 66)
        Me.txtdescripcion.Name = "txtdescripcion"
        Me.txtdescripcion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtdescripcion.Size = New System.Drawing.Size(382, 35)
        Me.txtdescripcion.TabIndex = 9
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtdescripcion, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(138, 63)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(430, 19)
        Me._lblDescripcion_2.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lbletiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_4, False)
        Me._lbletiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_4, "Default")
        Me._lbletiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_4.Location = New System.Drawing.Point(11, 63)
        Me._lbletiqueta_4.Name = "_lbletiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_4, "5211")
        Me._lbletiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_4.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_4.TabIndex = 13
        Me._lbletiqueta_4.Text = "*Estado Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_4, "")
        '
        '_lbletiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_7, False)
        Me._lbletiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_7, "Default")
        Me._lbletiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_7.Location = New System.Drawing.Point(10, 20)
        Me._lbletiqueta_7.Name = "_lbletiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_7, "500348")
        Me._lbletiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_7.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_7.TabIndex = 27
        Me._lbletiqueta_7.Text = "*Fecha:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_7, "")
        '
        '_lbletiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_5, False)
        Me._lbletiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_5, "Default")
        Me._lbletiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_5.Location = New System.Drawing.Point(302, 20)
        Me._lbletiqueta_5.Name = "_lbletiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_5, "500366")
        Me._lbletiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_5.Size = New System.Drawing.Size(100, 20)
        Me._lbletiqueta_5.TabIndex = 26
        Me._lbletiqueta_5.Text = "*Usuario:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_5, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(419, 19)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(150, 19)
        Me._lblDescripcion_1.TabIndex = 11
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lbletiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_3, False)
        Me._lbletiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_3, "Default")
        Me._lbletiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_3.Location = New System.Drawing.Point(10, 43)
        Me._lbletiqueta_3.Name = "_lbletiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_3, "2420")
        Me._lbletiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_3.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_3.TabIndex = 24
        Me._lbletiqueta_3.Text = "*Oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_3, "")
        '
        'lblOficinaDesm
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblOficinaDesm, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblOficinaDesm, False)
        Me.lblOficinaDesm.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblOficinaDesm.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblOficinaDesm, "Default")
        Me.lblOficinaDesm.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblOficinaDesm.Location = New System.Drawing.Point(187, 42)
        Me.lblOficinaDesm.Name = "lblOficinaDesm"
        Me.lblOficinaDesm.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblOficinaDesm.Size = New System.Drawing.Size(382, 19)
        Me.lblOficinaDesm.TabIndex = 13
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblOficinaDesm, "")
        '
        'lblOficinaMarca
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblOficinaMarca, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblOficinaMarca, False)
        Me.lblOficinaMarca.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblOficinaMarca.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblOficinaMarca, "Default")
        Me.lblOficinaMarca.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblOficinaMarca.Location = New System.Drawing.Point(187, 43)
        Me.lblOficinaMarca.Name = "lblOficinaMarca"
        Me.lblOficinaMarca.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblOficinaMarca.Size = New System.Drawing.Size(382, 19)
        Me.lblOficinaMarca.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblOficinaMarca, "")
        '
        '_lbletiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_2, False)
        Me._lbletiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_2, "Default")
        Me._lbletiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_2.Location = New System.Drawing.Point(10, 43)
        Me._lbletiqueta_2.Name = "_lbletiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_2, "2420")
        Me._lbletiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_2.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_2.TabIndex = 21
        Me._lbletiqueta_2.Text = "*Oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_2, "")
        '
        '_lbletiqueta_18
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_18, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_18, False)
        Me._lbletiqueta_18.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_18, "Default")
        Me._lbletiqueta_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_18.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_18.Location = New System.Drawing.Point(10, 66)
        Me._lbletiqueta_18.Name = "_lbletiqueta_18"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_18, "2422")
        Me._lbletiqueta_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_18.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_18.TabIndex = 17
        Me._lbletiqueta_18.Text = "*Concepto Exención:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_18, "")
        '
        '_lblDescripcion_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_14, False)
        Me._lblDescripcion_14.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_14.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_14, "Default")
        Me._lblDescripcion_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_14.Location = New System.Drawing.Point(419, 19)
        Me._lblDescripcion_14.Name = "_lblDescripcion_14"
        Me._lblDescripcion_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_14.Size = New System.Drawing.Size(150, 19)
        Me._lblDescripcion_14.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_14, "")
        '
        '_lbletiqueta_20
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_20, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_20, False)
        Me._lbletiqueta_20.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_20, "Default")
        Me._lbletiqueta_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_20.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_20.Location = New System.Drawing.Point(302, 20)
        Me._lbletiqueta_20.Name = "_lbletiqueta_20"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_20, "500366")
        Me._lbletiqueta_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_20.Size = New System.Drawing.Size(100, 20)
        Me._lbletiqueta_20.TabIndex = 18
        Me._lbletiqueta_20.Text = "*Usuario:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_20, "")
        '
        '_lbletiqueta_19
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_19, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_19, False)
        Me._lbletiqueta_19.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_19, "Default")
        Me._lbletiqueta_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_19.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_19.Location = New System.Drawing.Point(10, 20)
        Me._lbletiqueta_19.Name = "_lbletiqueta_19"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_19, "500348")
        Me._lbletiqueta_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_19.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_19.TabIndex = 16
        Me._lbletiqueta_19.Text = "*Fecha:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_19, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(138, 40)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(430, 19)
        Me._lblDescripcion_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lbletiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_6, False)
        Me._lbletiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_6, "Default")
        Me._lbletiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_6.Location = New System.Drawing.Point(11, 17)
        Me._lbletiqueta_6.Name = "_lbletiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_6, "5048")
        Me._lbletiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_6.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_6.TabIndex = 9
        Me._lbletiqueta_6.Text = "*Producto :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_6, "")
        '
        '_lbletiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_1, False)
        Me._lbletiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_1, "Default")
        Me._lbletiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_1.Location = New System.Drawing.Point(11, 40)
        Me._lbletiqueta_1.Name = "_lbletiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_1, "2438")
        Me._lbletiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_1.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_1.TabIndex = 11
        Me._lbletiqueta_1.Text = "*Nombre Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_1, "")
        '
        '_lbletiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_0, False)
        Me._lbletiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_0, "Default")
        Me._lbletiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_0.Location = New System.Drawing.Point(302, 17)
        Me._lbletiqueta_0.Name = "_lbletiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_0, "2400")
        Me._lbletiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_0.Size = New System.Drawing.Size(100, 20)
        Me._lbletiqueta_0.TabIndex = 10
        Me._lbletiqueta_0.Text = "*No. de Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_0, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me._txtCampo_12)
        Me.GroupBox1.Controls.Add(Me.lblFecMarca)
        Me.GroupBox1.Controls.Add(Me.lblOfiMarca)
        Me.GroupBox1.Controls.Add(Me.txtdescripcion)
        Me.GroupBox1.Controls.Add(Me.lblOficinaMarca)
        Me.GroupBox1.Controls.Add(Me._lbletiqueta_2)
        Me.GroupBox1.Controls.Add(Me._lbletiqueta_18)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_14)
        Me.GroupBox1.Controls.Add(Me._lbletiqueta_20)
        Me.GroupBox1.Controls.Add(Me._lbletiqueta_19)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(9, 105)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "2439")
        Me.GroupBox1.Size = New System.Drawing.Size(575, 108)
        Me.GroupBox1.TabIndex = 1
        Me.GroupBox1.Text = "*Datos Marcación de Exención Cuenta :"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'GroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox2, False)
        Me.GroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox2.Controls.Add(Me.lblFecDesm)
        Me.GroupBox2.Controls.Add(Me.lblOfiDesmarca)
        Me.GroupBox2.Controls.Add(Me._lbletiqueta_7)
        Me.GroupBox2.Controls.Add(Me._lbletiqueta_5)
        Me.GroupBox2.Controls.Add(Me._lblDescripcion_1)
        Me.GroupBox2.Controls.Add(Me._lbletiqueta_3)
        Me.GroupBox2.Controls.Add(Me.lblOficinaDesm)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox2, "Default")
        Me.GroupBox2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox2.Location = New System.Drawing.Point(9, 216)
        Me.GroupBox2.Name = "GroupBox2"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox2, "2440")
        Me.GroupBox2.Size = New System.Drawing.Size(575, 71)
        Me.GroupBox2.TabIndex = 2
        Me.GroupBox2.Text = "*Datos Desmarcación de Exención Cuenta :"
        Me.GroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox2, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me.GroupBox2)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._cmdBoton_5)
        Me.PFormas.Controls.Add(Me._cmdBoton_6)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(595, 297)
        Me.PFormas.TabIndex = 35
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.Controls.Add(Me.cmbTipo)
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_0)
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_1)
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_6)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_0)
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_4)
        Me.UltraGroupBox1.Controls.Add(Me.mskCuenta)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_2)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(575, 92)
        Me.UltraGroupBox1.TabIndex = 0
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBRtaCifin, Me.TSBMarcar, Me.TSBDesmarcar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(615, 25)
        Me.TSBotones.TabIndex = 36
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBRtaCifin
        '
        Me.TSBRtaCifin.ForeColor = System.Drawing.Color.Black
        Me.TSBRtaCifin.Image = CType(resources.GetObject("TSBRtaCifin.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBRtaCifin, "2007")
        Me.TSBRtaCifin.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBRtaCifin.Name = "TSBRtaCifin"
        Me.COBISResourceProvider.SetResourceID(Me.TSBRtaCifin, "2444")
        Me.TSBRtaCifin.Size = New System.Drawing.Size(81, 22)
        Me.TSBRtaCifin.Text = "*&Rta CIFIN"
        '
        'TSBMarcar
        '
        Me.TSBMarcar.ForeColor = System.Drawing.Color.Black
        Me.TSBMarcar.Image = CType(resources.GetObject("TSBMarcar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBMarcar, "2011")
        Me.TSBMarcar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBMarcar.Name = "TSBMarcar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBMarcar, "2445")
        Me.TSBMarcar.Size = New System.Drawing.Size(69, 22)
        Me.TSBMarcar.Tag = "4142"
        Me.TSBMarcar.Text = "*&Marcar"
        '
        'TSBDesmarcar
        '
        Me.TSBDesmarcar.ForeColor = System.Drawing.Color.Black
        Me.TSBDesmarcar.Image = CType(resources.GetObject("TSBDesmarcar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBDesmarcar, "2023")
        Me.TSBDesmarcar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBDesmarcar.Name = "TSBDesmarcar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBDesmarcar, "2446")
        Me.TSBDesmarcar.Size = New System.Drawing.Size(88, 22)
        Me.TSBDesmarcar.Tag = "4148"
        Me.TSBDesmarcar.Text = "*&Desmarcar"
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
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FTranUpGMFClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(4, 116)
        Me.Name = "FTranUpGMFClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(615, 342)
        Me.Text = "Actualización GMF Ahorros/Corrientes"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        CType(Me.GroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox2.ResumeLayout(False)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(12) = _txtCampo_12
    End Sub
    Sub Initializelbletiqueta()
        Me.lbletiqueta(4) = _lbletiqueta_4
        Me.lbletiqueta(7) = _lbletiqueta_7
        Me.lbletiqueta(5) = _lbletiqueta_5
        Me.lbletiqueta(3) = _lbletiqueta_3
        Me.lbletiqueta(2) = _lbletiqueta_2
        Me.lbletiqueta(18) = _lbletiqueta_18
        Me.lbletiqueta(20) = _lbletiqueta_20
        Me.lbletiqueta(19) = _lbletiqueta_19
        Me.lbletiqueta(6) = _lbletiqueta_6
        Me.lbletiqueta(1) = _lbletiqueta_1
        Me.lbletiqueta(0) = _lbletiqueta_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(14) = _lblDescripcion_14
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(6) = _cmdBoton_6
    End Sub
    'Sub InitializeLine1()
    '    Me.Line1(3) = _Line1_3
    '    Me.Line1(2) = _Line1_2
    '    Me.Line1(1) = _Line1_1
    '    Me.Line1(0) = _Line1_0
    'End Sub
    '  Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBRtaCifin As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBMarcar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBDesmarcar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


