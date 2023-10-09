Imports COBISCorp.tCOBIS.PER.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FconVarCostoClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtCampo()
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
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Public WithEvents grdtasasold As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public WithEvents grdtasas As COBISCorp.Framework.UI.Components.COBISSpread
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_12 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_11 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Public Line1(2) As System.Windows.Forms.Label
	Public cmdBoton(4) As System.Windows.Forms.Button
	Public lblDescripcion(12) As System.Windows.Forms.Label
	Public lblEtiqueta(10) As System.Windows.Forms.Label
	Public txtCampo(4) As System.Windows.Forms.TextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FconVarCostoClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me.grdtasasold = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.grdtasas = New COBISCorp.Framework.UI.Components.COBISSpread()
        Me.grdtasas_Sheet1 = New FarPoint.Win.Spread.SheetView()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_12 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_11 = New System.Windows.Forms.Label()
        Me._lblDescripcion_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBImprimir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.Panel1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdtasasold, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdtasas, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdtasas_Sheet1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TSBotones.SuspendLayout()
        CType(Me.Panel1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel1.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
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
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_4.Location = New System.Drawing.Point(136, 10)
        Me._txtCampo_4.MaxLength = 5
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_4.TabIndex = 0
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
        Me._txtCampo_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_0.Location = New System.Drawing.Point(136, 56)
        Me._txtCampo_0.MaxLength = 4
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
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
        Me._txtCampo_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_2.Location = New System.Drawing.Point(136, 33)
        Me._txtCampo_2.MaxLength = 4
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_2.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
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
        Me._txtCampo_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_1.Location = New System.Drawing.Point(136, 102)
        Me._txtCampo_1.MaxLength = 2
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_1.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        'grdtasasold
        '
        Me.grdtasasold._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdtasasold, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdtasasold, False)
        Me.grdtasasold.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdtasasold.Clip = ""
        Me.grdtasasold.Col = CType(1, Short)
        Me.grdtasasold.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdtasasold.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdtasasold.ColorSelectedCells = System.Drawing.SystemColors.GradientInactiveCaption
        Me.COBISStyleProvider.SetControlStyle(Me.grdtasasold, "Default")
        Me.grdtasasold.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdtasasold, True)
        Me.grdtasasold.FixedCols = CType(1, Short)
        Me.grdtasasold.FixedRows = CType(1, Short)
        Me.grdtasasold.ForeColor = System.Drawing.Color.Black
        Me.grdtasasold.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdtasasold.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdtasasold.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdtasasold.HighLight = True
        Me.grdtasasold.Location = New System.Drawing.Point(214, 151)
        Me.grdtasasold.Name = "grdtasasold"
        Me.grdtasasold.Picture = Nothing
        Me.grdtasasold.Row = CType(1, Short)
        Me.grdtasasold.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdtasasold.Size = New System.Drawing.Size(44, 38)
        Me.grdtasasold.Sort = CType(2, Short)
        Me.grdtasasold.TabIndex = 4
        Me.grdtasasold.TopRow = CType(1, Short)
        Me.grdtasasold.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdtasasold, "")
        Me.COBISViewResizer.SetxIncrement(Me.grdtasasold, False)
        Me.COBISViewResizer.SetyIncrement(Me.grdtasasold, False)
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
        Me._cmdBoton_3.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Image = CType(resources.GetObject("_cmdBoton_3.Image"), System.Drawing.Image)
        Me._cmdBoton_3.Location = New System.Drawing.Point(199, 94)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 49)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 27
        Me._cmdBoton_3.Tag = "4086"
        Me._cmdBoton_3.Text = "Sig&tes."
        Me._cmdBoton_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.Location = New System.Drawing.Point(199, 42)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 28
        Me._cmdBoton_0.Tag = "4086"
        Me._cmdBoton_0.Text = "&Buscar"
        Me._cmdBoton_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(199, 344)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 49)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 29
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(199, 294)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 49)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 30
        Me._cmdBoton_1.Text = "&Limpiar"
        Me._cmdBoton_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_4.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Image = CType(resources.GetObject("_cmdBoton_4.Image"), System.Drawing.Image)
        Me._cmdBoton_4.Location = New System.Drawing.Point(199, 242)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 26
        Me._cmdBoton_4.Tag = "4119"
        Me._cmdBoton_4.Text = "&Imprimir"
        Me._cmdBoton_4.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        'grdtasas
        '
        Me.grdtasas.AccessibleDescription = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdtasas, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdtasas, False)
        Me.grdtasas.BackColorStyle = COBISCorp.Framework.UI.Components.BackColorStyleConstants.BackColorStyleOverGrid
        Me.COBISStyleProvider.SetControlStyle(Me.grdtasas, "Default")
        Me.grdtasas.CursorStyle = COBISCorp.Framework.UI.Components.CursorStyleConstants.CursorStyleUserDefined
        Me.grdtasas.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.grdtasas.GridColor = System.Drawing.SystemColors.Control
        Me.grdtasas.Location = New System.Drawing.Point(10, 20)
        Me.grdtasas.Name = "grdtasas"
        Me.grdtasas.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.grdtasas.SelBackColor = System.Drawing.Color.LightGray
        Me.grdtasas.Sheets.AddRange(New FarPoint.Win.Spread.SheetView() {Me.grdtasas_Sheet1})
        Me.grdtasas.Size = New System.Drawing.Size(537, 225)
        Me.grdtasas.StartingColNumber = 1
        Me.grdtasas.StartingRowNumber = 1
        Me.grdtasas.TabIndex = 4
        Me.grdtasas.TabStripRatio = 0.6R
        Me.grdtasas.UnitType = COBISCorp.Framework.UI.Components.UnitTypeConstants.UnitTypeVGABase
        Me.grdtasas.VisibleCols = 11
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdtasas, "")
        '
        'grdtasas_Sheet1
        '
        Me.grdtasas_Sheet1.Reset()
        Me.grdtasas_Sheet1.SheetName = "Sheet1"
        'Formulas and custom names must be loaded with R1C1 reference style
        Me.grdtasas_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.R1C1
        Me.grdtasas_Sheet1.ColumnCount = 11
        Me.grdtasas_Sheet1.RowCount = 0
        Me.grdtasas_Sheet1.ActiveRowIndex = -1
        Me.grdtasas_Sheet1.Columns.Get(6).Width = 120.0!
        Me.grdtasas_Sheet1.HorizontalGridLine = New FarPoint.Win.Spread.GridLine(FarPoint.Win.Spread.GridLineType.Flat, System.Drawing.SystemColors.Control)
        Me.grdtasas_Sheet1.RowHeader.Columns.Default.Resizable = False
        Me.grdtasas_Sheet1.Rows.Default.Height = 30.0!
        Me.grdtasas_Sheet1.SelectionBackColor = System.Drawing.Color.LightGray
        Me.grdtasas_Sheet1.SelectionStyle = FarPoint.Win.Spread.SelectionStyles.SelectionColors
        Me.grdtasas_Sheet1.VerticalGridLine = New FarPoint.Win.Spread.GridLine(FarPoint.Win.Spread.GridLineType.Flat, System.Drawing.SystemColors.Control)
        Me.grdtasas_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.A1
        Me.grdtasas.SetActiveViewport(0, -1, 0)
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
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "1149")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(108, 13)
        Me._lblEtiqueta_10.TabIndex = 25
        Me._lblEtiqueta_10.Text = "*Código Sucursal:"
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
        Me._lblDescripcion_12.Location = New System.Drawing.Point(201, 10)
        Me._lblDescripcion_12.Name = "_lblDescripcion_12"
        Me._lblDescripcion_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_12.Size = New System.Drawing.Size(362, 20)
        Me._lblDescripcion_12.TabIndex = 24
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_12, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.AutoSize = True
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(17, 292)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(62, 13)
        Me._lblEtiqueta_3.TabIndex = 8
        Me._lblEtiqueta_3.Text = "Producto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        Me.COBISViewResizer.SetxIncrement(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetyIncrement(Me._lblEtiqueta_3, False)
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
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(18, 270)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(56, 13)
        Me._lblEtiqueta_4.TabIndex = 10
        Me._lblEtiqueta_4.Text = "Moneda:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        Me.COBISViewResizer.SetxIncrement(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetyIncrement(Me._lblEtiqueta_4, False)
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
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 297)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(109, 13)
        Me._lblEtiqueta_5.TabIndex = 11
        Me._lblEtiqueta_5.Text = "Tipo de Producto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        Me.COBISViewResizer.SetxIncrement(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetyIncrement(Me._lblEtiqueta_5, False)
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(202, 290)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(345, 19)
        Me._lblDescripcion_2.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        Me.COBISViewResizer.SetxIncrement(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetyIncrement(Me._lblDescripcion_2, False)
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(206, 255)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(345, 19)
        Me._lblDescripcion_4.TabIndex = 16
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        Me.COBISViewResizer.SetxIncrement(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetyIncrement(Me._lblDescripcion_4, False)
        '
        '_lblDescripcion_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_6, False)
        Me._lblDescripcion_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_6, "Default")
        Me._lblDescripcion_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_6.Location = New System.Drawing.Point(142, 289)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(62, 19)
        Me._lblDescripcion_6.TabIndex = 18
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_6, "")
        Me.COBISViewResizer.SetxIncrement(Me._lblDescripcion_6, False)
        Me.COBISViewResizer.SetyIncrement(Me._lblDescripcion_6, False)
        '
        '_lblDescripcion_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_7, False)
        Me._lblDescripcion_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_7, "Default")
        Me._lblDescripcion_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_7.Location = New System.Drawing.Point(151, 274)
        Me._lblDescripcion_7.Name = "_lblDescripcion_7"
        Me._lblDescripcion_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_7.Size = New System.Drawing.Size(62, 19)
        Me._lblDescripcion_7.TabIndex = 19
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_7, "")
        Me.COBISViewResizer.SetxIncrement(Me._lblDescripcion_7, False)
        Me.COBISViewResizer.SetyIncrement(Me._lblDescripcion_7, False)
        '
        '_lblDescripcion_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_8, False)
        Me._lblDescripcion_8.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_8.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_8, "Default")
        Me._lblDescripcion_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_8.Location = New System.Drawing.Point(213, 279)
        Me._lblDescripcion_8.Name = "_lblDescripcion_8"
        Me._lblDescripcion_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_8.Size = New System.Drawing.Size(345, 19)
        Me._lblDescripcion_8.TabIndex = 20
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_8, "")
        Me.COBISViewResizer.SetxIncrement(Me._lblDescripcion_8, False)
        Me.COBISViewResizer.SetyIncrement(Me._lblDescripcion_8, False)
        '
        '_lblDescripcion_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_10, False)
        Me._lblDescripcion_10.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_10.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_10, "Default")
        Me._lblDescripcion_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_10.Location = New System.Drawing.Point(136, 244)
        Me._lblDescripcion_10.Name = "_lblDescripcion_10"
        Me._lblDescripcion_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_10.Size = New System.Drawing.Size(62, 19)
        Me._lblDescripcion_10.TabIndex = 22
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_10, "")
        Me.COBISViewResizer.SetxIncrement(Me._lblDescripcion_10, False)
        Me.COBISViewResizer.SetyIncrement(Me._lblDescripcion_10, False)
        '
        '_lblDescripcion_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_11, False)
        Me._lblDescripcion_11.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_11.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_11, "Default")
        Me._lblDescripcion_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_11.Location = New System.Drawing.Point(136, 79)
        Me._lblDescripcion_11.Name = "_lblDescripcion_11"
        Me._lblDescripcion_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_11.Size = New System.Drawing.Size(62, 20)
        Me._lblDescripcion_11.TabIndex = 23
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_11, "")
        '
        '_lblDescripcion_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_9, False)
        Me._lblDescripcion_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_9, "Default")
        Me._lblDescripcion_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_9.Location = New System.Drawing.Point(201, 102)
        Me._lblDescripcion_9.Name = "_lblDescripcion_9"
        Me._lblDescripcion_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_9.Size = New System.Drawing.Size(362, 20)
        Me._lblDescripcion_9.TabIndex = 21
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_9, "")
        '
        '_lblDescripcion_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_5, False)
        Me._lblDescripcion_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_5, "Default")
        Me._lblDescripcion_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_5.Location = New System.Drawing.Point(201, 79)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(362, 20)
        Me._lblDescripcion_5.TabIndex = 17
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_5, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(201, 56)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(362, 20)
        Me._lblDescripcion_1.TabIndex = 14
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(201, 33)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(362, 20)
        Me._lblDescripcion_0.TabIndex = 13
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.AutoSize = True
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "1668")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(98, 13)
        Me._lblEtiqueta_1.TabIndex = 12
        Me._lblEtiqueta_1.Text = "*Producto Final:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
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
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 79)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "1691")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(121, 13)
        Me._lblEtiqueta_2.TabIndex = 6
        Me._lblEtiqueta_2.Text = "*Rubro del Servicio:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
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
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 55)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "1712")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(125, 13)
        Me._lblEtiqueta_6.TabIndex = 7
        Me._lblEtiqueta_6.Text = "*Servicio Disponible:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
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
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(10, 102)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "1751")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(100, 13)
        Me._lblEtiqueta_7.TabIndex = 9
        Me._lblEtiqueta_7.Text = "*Tipo de Rango:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguientes, Me.TSBImprimir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(589, 25)
        Me.TSBotones.TabIndex = 34
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
        'TSBSiguientes
        '
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "30001")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "1008")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Text = "*Siguientes"
        '
        'TSBImprimir
        '
        Me.TSBImprimir.Image = CType(resources.GetObject("TSBImprimir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBImprimir, "30009")
        Me.TSBImprimir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBImprimir.Name = "TSBImprimir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBImprimir, "1408")
        Me.TSBImprimir.Size = New System.Drawing.Size(78, 22)
        Me.TSBImprimir.Text = "*Imprimir"
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
        'Panel1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Panel1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Panel1, False)
        Me.Panel1.BackColorInternal = System.Drawing.Color.White
        Me.Panel1.Controls.Add(Me.GroupBox1)
        Me.Panel1.Controls.Add(Me._lblEtiqueta_10)
        Me.Panel1.Controls.Add(Me._txtCampo_4)
        Me.Panel1.Controls.Add(Me._lblEtiqueta_7)
        Me.Panel1.Controls.Add(Me._txtCampo_0)
        Me.Panel1.Controls.Add(Me._lblEtiqueta_6)
        Me.Panel1.Controls.Add(Me._txtCampo_2)
        Me.Panel1.Controls.Add(Me._lblEtiqueta_2)
        Me.Panel1.Controls.Add(Me._txtCampo_1)
        Me.Panel1.Controls.Add(Me._lblEtiqueta_1)
        Me.Panel1.Controls.Add(Me._lblDescripcion_0)
        Me.Panel1.Controls.Add(Me._lblDescripcion_1)
        Me.Panel1.Controls.Add(Me._lblDescripcion_5)
        Me.Panel1.Controls.Add(Me._lblDescripcion_9)
        Me.Panel1.Controls.Add(Me._lblDescripcion_11)
        Me.Panel1.Controls.Add(Me._lblDescripcion_10)
        Me.Panel1.Controls.Add(Me._lblDescripcion_8)
        Me.Panel1.Controls.Add(Me._lblDescripcion_12)
        Me.Panel1.Controls.Add(Me._lblDescripcion_7)
        Me.Panel1.Controls.Add(Me._lblEtiqueta_3)
        Me.Panel1.Controls.Add(Me._lblDescripcion_6)
        Me.Panel1.Controls.Add(Me._lblEtiqueta_4)
        Me.Panel1.Controls.Add(Me._lblDescripcion_4)
        Me.Panel1.Controls.Add(Me._lblEtiqueta_5)
        Me.Panel1.Controls.Add(Me._lblDescripcion_2)
        Me.COBISStyleProvider.SetControlStyle(Me.Panel1, "Default")
        Me.Panel1.Location = New System.Drawing.Point(10, 36)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(571, 394)
        Me.Panel1.TabIndex = 35
        Me.Panel1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Panel1, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdtasas)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold)
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 132)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "2526")
        Me.GroupBox1.Size = New System.Drawing.Size(553, 252)
        Me.GroupBox1.TabIndex = 36
        Me.GroupBox1.Text = "*Listado Histórico de Costos y Tasas:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'FconVarCostoClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.grdtasasold)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Location = New System.Drawing.Point(89, 102)
        Me.Name = "FconVarCostoClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(589, 434)
        Me.Tag = "3008"
        Me.Text = "Consulta histórica de costos y tasas"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdtasasold, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdtasas, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdtasas_Sheet1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.Panel1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(1) = _txtCampo_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(6) = _lblEtiqueta_6
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(12) = _lblDescripcion_12
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(6) = _lblDescripcion_6
        Me.lblDescripcion(7) = _lblDescripcion_7
        Me.lblDescripcion(8) = _lblDescripcion_8
        Me.lblDescripcion(10) = _lblDescripcion_10
        Me.lblDescripcion(11) = _lblDescripcion_11
        Me.lblDescripcion(9) = _lblDescripcion_9
        Me.lblDescripcion(5) = _lblDescripcion_5
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(4) = _cmdBoton_4
    End Sub

    Friend WithEvents grdtasas_Sheet1 As FarPoint.Win.Spread.SheetView
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBImprimir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents Panel1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region 
End Class


