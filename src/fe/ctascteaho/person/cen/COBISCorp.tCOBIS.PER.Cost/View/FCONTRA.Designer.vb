Imports COBISCorp.tCOBIS.PER.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FContratacionClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtCampo()
		InitializelblEtiqueta()
		InitializelblDescripcion()
		InitializegrdServicios()
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
    Private WithEvents _txtCampo_5 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_6 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _grdServicios_1 As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents cmbEnte As System.Windows.Forms.ComboBox
    Private WithEvents _grdServicios_0 As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_9 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
	Public cmdBoton(3) As System.Windows.Forms.Button
	Public grdServicios(1) As COBISCorp.Framework.UI.Components.COBISGrid
	Public lblDescripcion(9) As System.Windows.Forms.Label
	Public lblEtiqueta(10) As System.Windows.Forms.Label
	Public txtCampo(6) As System.Windows.Forms.TextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FContratacionClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtCampo_5 = New System.Windows.Forms.TextBox()
        Me._txtCampo_6 = New System.Windows.Forms.TextBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._grdServicios_1 = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.cmbEnte = New System.Windows.Forms.ComboBox()
        Me._grdServicios_0 = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_9 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me._grdServicios_1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._grdServicios_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TSBotones.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox2.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
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
        '_txtCampo_5
        '
        Me._txtCampo_5.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_5, False)
        Me._txtCampo_5.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_5.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_5, "Default")
        Me._txtCampo_5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_5.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_5.Location = New System.Drawing.Point(145, 147)
        Me._txtCampo_5.MaxLength = 10
        Me._txtCampo_5.Name = "_txtCampo_5"
        Me._txtCampo_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_5.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_5.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_5, "")
        '
        '_txtCampo_6
        '
        Me._txtCampo_6.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_6, False)
        Me._txtCampo_6.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_6.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_6, "Default")
        Me._txtCampo_6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_6.Enabled = False
        Me._txtCampo_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_6.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_6.Location = New System.Drawing.Point(145, 170)
        Me._txtCampo_6.MaxLength = 10
        Me._txtCampo_6.Name = "_txtCampo_6"
        Me._txtCampo_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_6.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_6.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_6, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_3.Location = New System.Drawing.Point(145, 10)
        Me._txtCampo_3.MaxLength = 10
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_3.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
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
        Me._cmdBoton_0.Enabled = False
        Me._cmdBoton_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.Location = New System.Drawing.Point(151, 238)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 11
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Tag = "4068"
        Me._cmdBoton_0.Text = "&Transmitir"
        Me._cmdBoton_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_grdServicios_1
        '
        Me._grdServicios_1._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me._grdServicios_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._grdServicios_1, False)
        Me._grdServicios_1.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me._grdServicios_1.Clip = ""
        Me._grdServicios_1.Col = CType(1, Short)
        Me._grdServicios_1.ColorFixedCols = System.Drawing.SystemColors.Control
        Me._grdServicios_1.ColorFixedRows = System.Drawing.SystemColors.Control
        Me._grdServicios_1.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me._grdServicios_1, "Default")
        Me._grdServicios_1.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me._grdServicios_1, True)
        Me._grdServicios_1.FixedCols = CType(1, Short)
        Me._grdServicios_1.FixedRows = CType(1, Short)
        Me._grdServicios_1.ForeColor = System.Drawing.Color.Black
        Me._grdServicios_1.ForeColorFixedCols = System.Drawing.Color.Empty
        Me._grdServicios_1.ForeColorFixedRows = System.Drawing.Color.Empty
        Me._grdServicios_1.GridColor = System.Drawing.SystemColors.ControlDark
        Me._grdServicios_1.HighLight = True
        Me._grdServicios_1.Location = New System.Drawing.Point(6, 19)
        Me._grdServicios_1.Name = "_grdServicios_1"
        Me._grdServicios_1.Picture = Nothing
        Me._grdServicios_1.Row = CType(1, Short)
        Me._grdServicios_1.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me._grdServicios_1.Size = New System.Drawing.Size(560, 102)
        Me._grdServicios_1.Sort = CType(2, Short)
        Me._grdServicios_1.TabIndex = 10
        Me._grdServicios_1.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me._grdServicios_1, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_4.Location = New System.Drawing.Point(145, 124)
        Me._txtCampo_4.MaxLength = 10
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_4.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_0.Location = New System.Drawing.Point(145, 55)
        Me._txtCampo_0.MaxLength = 10
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
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
        Me._cmdBoton_3.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Image = CType(resources.GetObject("_cmdBoton_3.Image"), System.Drawing.Image)
        Me._cmdBoton_3.Location = New System.Drawing.Point(151, 36)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 8
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Tag = "4070"
        Me._cmdBoton_3.Text = "&Buscar"
        Me._cmdBoton_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'cmbEnte
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbEnte, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbEnte, False)
        Me.cmbEnte.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbEnte, "Default")
        Me.cmbEnte.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbEnte.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbEnte.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbEnte.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbEnte.Location = New System.Drawing.Point(145, 33)
        Me.cmbEnte.Name = "cmbEnte"
        Me.cmbEnte.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbEnte.Size = New System.Drawing.Size(160, 19)
        Me.cmbEnte.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbEnte, "")
        '
        '_grdServicios_0
        '
        Me._grdServicios_0._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me._grdServicios_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._grdServicios_0, False)
        Me._grdServicios_0.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me._grdServicios_0.Clip = ""
        Me._grdServicios_0.Col = CType(1, Short)
        Me._grdServicios_0.ColorFixedCols = System.Drawing.SystemColors.Control
        Me._grdServicios_0.ColorFixedRows = System.Drawing.SystemColors.Control
        Me._grdServicios_0.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me._grdServicios_0, "Default")
        Me._grdServicios_0.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me._grdServicios_0, True)
        Me._grdServicios_0.FixedCols = CType(1, Short)
        Me._grdServicios_0.FixedRows = CType(1, Short)
        Me._grdServicios_0.ForeColor = System.Drawing.Color.Black
        Me._grdServicios_0.ForeColorFixedCols = System.Drawing.Color.Empty
        Me._grdServicios_0.ForeColorFixedRows = System.Drawing.Color.Empty
        Me._grdServicios_0.GridColor = System.Drawing.SystemColors.ControlDark
        Me._grdServicios_0.HighLight = True
        Me._grdServicios_0.Location = New System.Drawing.Point(6, 19)
        Me._grdServicios_0.Name = "_grdServicios_0"
        Me._grdServicios_0.Picture = Nothing
        Me._grdServicios_0.Row = CType(1, Short)
        Me._grdServicios_0.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me._grdServicios_0.Size = New System.Drawing.Size(560, 74)
        Me._grdServicios_0.Sort = CType(2, Short)
        Me._grdServicios_0.TabIndex = 9
        Me._grdServicios_0.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me._grdServicios_0, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_1.Location = New System.Drawing.Point(145, 78)
        Me._txtCampo_1.MaxLength = 2
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_1.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_2.Location = New System.Drawing.Point(145, 101)
        Me._txtCampo_2.MaxLength = 10
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_2.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
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
        Me._cmdBoton_2.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Image = CType(resources.GetObject("_cmdBoton_2.Image"), System.Drawing.Image)
        Me._cmdBoton_2.Location = New System.Drawing.Point(151, 339)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 13
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "&Salir"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_1.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Image = CType(resources.GetObject("_cmdBoton_1.Image"), System.Drawing.Image)
        Me._cmdBoton_1.Location = New System.Drawing.Point(151, 288)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 12
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "&Limpiar"
        Me._cmdBoton_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_lblEtiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.AutoSize = True
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(10, 147)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "1718")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(62, 13)
        Me._lblEtiqueta_10.TabIndex = 34
        Me._lblEtiqueta_10.Text = "*Servicio:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        '_lblDescripcion_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_8, False)
        Me._lblDescripcion_8.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_8.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_8, "Default")
        Me._lblDescripcion_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_8.Location = New System.Drawing.Point(210, 147)
        Me._lblDescripcion_8.Name = "_lblDescripcion_8"
        Me._lblDescripcion_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_8.Size = New System.Drawing.Size(372, 20)
        Me._lblDescripcion_8.TabIndex = 33
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_8, "")
        '
        '_lblDescripcion_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_9, False)
        Me._lblDescripcion_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_9, "Default")
        Me._lblDescripcion_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_9.Location = New System.Drawing.Point(210, 170)
        Me._lblDescripcion_9.Name = "_lblDescripcion_9"
        Me._lblDescripcion_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_9.Size = New System.Drawing.Size(372, 20)
        Me._lblDescripcion_9.TabIndex = 32
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_9, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.AutoSize = True
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(10, 170)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "1693")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(50, 13)
        Me._lblEtiqueta_9.TabIndex = 31
        Me._lblEtiqueta_9.Text = "*Rubro:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.AutoSize = True
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "1149")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(108, 13)
        Me._lblEtiqueta_8.TabIndex = 30
        Me._lblEtiqueta_8.Text = "*Código Sucursal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblDescripcion_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_7, False)
        Me._lblDescripcion_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_7, "Default")
        Me._lblDescripcion_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_7.Location = New System.Drawing.Point(210, 10)
        Me._lblDescripcion_7.Name = "_lblDescripcion_7"
        Me._lblDescripcion_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_7.Size = New System.Drawing.Size(372, 20)
        Me._lblDescripcion_7.TabIndex = 29
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
        Me._lblDescripcion_6.Location = New System.Drawing.Point(145, 219)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(62, 20)
        Me._lblDescripcion_6.TabIndex = 28
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_6, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.AutoSize = True
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 219)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(119, 13)
        Me._lblEtiqueta_6.TabIndex = 27
        Me._lblEtiqueta_6.Text = "Producto - Moneda:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(260, 229)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(307, 20)
        Me._lblDescripcion_4.TabIndex = 26
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(210, 219)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(62, 20)
        Me._lblDescripcion_3.TabIndex = 25
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblDescripcion_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_5, False)
        Me._lblDescripcion_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_5, "Default")
        Me._lblDescripcion_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_5.Location = New System.Drawing.Point(210, 124)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(372, 20)
        Me._lblDescripcion_5.TabIndex = 23
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_5, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(210, 55)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(372, 20)
        Me._lblDescripcion_0.TabIndex = 16
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.AutoSize = True
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(10, 55)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "1147")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(105, 13)
        Me._lblEtiqueta_7.TabIndex = 17
        Me._lblEtiqueta_7.Text = "*Código Persona:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.AutoSize = True
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "1755")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(134, 13)
        Me._lblEtiqueta_4.TabIndex = 24
        Me._lblEtiqueta_4.Text = "*Tipo Personalización:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.AutoSize = True
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 78)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "1688")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(35, 13)
        Me._lblEtiqueta_0.TabIndex = 19
        Me._lblEtiqueta_0.Text = "*Rol:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(210, 78)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(372, 20)
        Me._lblDescripcion_1.TabIndex = 21
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(210, 101)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(372, 20)
        Me._lblDescripcion_2.TabIndex = 14
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.AutoSize = True
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 101)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "1668")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(98, 13)
        Me._lblEtiqueta_5.TabIndex = 15
        Me._lblEtiqueta_5.Text = "*Producto Final:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.AutoSize = True
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 124)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "1069")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(72, 13)
        Me._lblEtiqueta_2.TabIndex = 20
        Me._lblEtiqueta_2.Text = "*Categoría:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.TSBotones.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(617, 25)
        Me.TSBotones.TabIndex = 35
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "30000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "1003")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*Buscar"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "30007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "1009")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*Transmitir"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "30003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "1006")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*Salir"
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_8)
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_2)
        Me.PFormas.Controls.Add(Me._txtCampo_5)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_5)
        Me.PFormas.Controls.Add(Me._txtCampo_6)
        Me.PFormas.Controls.Add(Me._lblDescripcion_2)
        Me.PFormas.Controls.Add(Me._txtCampo_3)
        Me.PFormas.Controls.Add(Me._lblDescripcion_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me._txtCampo_4)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_4)
        Me.PFormas.Controls.Add(Me._txtCampo_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_7)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.PFormas.Controls.Add(Me.cmbEnte)
        Me.PFormas.Controls.Add(Me._lblDescripcion_5)
        Me.PFormas.Controls.Add(Me._txtCampo_1)
        Me.PFormas.Controls.Add(Me._lblDescripcion_3)
        Me.PFormas.Controls.Add(Me._txtCampo_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me._lblDescripcion_6)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_10)
        Me.PFormas.Controls.Add(Me._lblDescripcion_7)
        Me.PFormas.Controls.Add(Me._lblDescripcion_8)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_9)
        Me.PFormas.Controls.Add(Me._lblDescripcion_9)
        Me.PFormas.Controls.Add(Me._lblDescripcion_4)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(598, 458)
        Me.PFormas.TabIndex = 36
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.Controls.Add(Me._grdServicios_1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.Location = New System.Drawing.Point(10, 318)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.COBISResourceProvider.SetResourceID(Me.UltraGroupBox2, "1714")
        Me.UltraGroupBox2.Size = New System.Drawing.Size(572, 128)
        Me.UltraGroupBox2.TabIndex = 38
        Me.UltraGroupBox2.Text = "*Servicios Personalizables:"
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.Controls.Add(Me._grdServicios_0)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 201)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.UltraGroupBox1, "1828")
        Me.UltraGroupBox1.Size = New System.Drawing.Size(572, 110)
        Me.UltraGroupBox1.TabIndex = 37
        Me.UltraGroupBox1.Text = "*Valores de Servicios Contratados: "
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'FContratacionClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Location = New System.Drawing.Point(20, 86)
        Me.Name = "FContratacionClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(617, 503)
        Me.Text = "Contratación de Servicios"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me._grdServicios_1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._grdServicios_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox2.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(5) = _txtCampo_5
        Me.txtCampo(6) = _txtCampo_6
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(2) = _txtCampo_2
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(2) = _lblEtiqueta_2
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(8) = _lblDescripcion_8
        Me.lblDescripcion(9) = _lblDescripcion_9
        Me.lblDescripcion(7) = _lblDescripcion_7
        Me.lblDescripcion(6) = _lblDescripcion_6
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(5) = _lblDescripcion_5
        Me.lblDescripcion(0) = _lblDescripcion_0
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(2) = _lblDescripcion_2
    End Sub
    Sub InitializegrdServicios()
        Me.grdServicios(1) = _grdServicios_1
        Me.grdServicios(0) = _grdServicios_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(1) = _cmdBoton_1
    End Sub
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region 
End Class


