Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FTran602Class
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializepicVisto()
		InitializelblEtiqueta()
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
    Private WithEvents _picVisto_1 As System.Windows.Forms.PictureBox
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Public WithEvents txtCarta As System.Windows.Forms.TextBox
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _lblDescripcion_17 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_16 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_16 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_15 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_15 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_14 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_14 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_13 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_12 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_13 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_11 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_10 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_11 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_9 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_8 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_7 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
	Public Line1(2) As System.Windows.Forms.Label
	Public cmdBoton(6) As System.Windows.Forms.Button
	Public lblDescripcion(17) As System.Windows.Forms.Label
	Public lblEtiqueta(16) As System.Windows.Forms.Label
	Public picVisto(1) As System.Windows.Forms.PictureBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran602Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._picVisto_1 = New System.Windows.Forms.PictureBox()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me.txtCarta = New System.Windows.Forms.TextBox()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._lblDescripcion_17 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_16 = New System.Windows.Forms.Label()
        Me._lblDescripcion_16 = New System.Windows.Forms.Label()
        Me._lblDescripcion_15 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_15 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_14 = New System.Windows.Forms.Label()
        Me._lblDescripcion_14 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_13 = New System.Windows.Forms.Label()
        Me._lblDescripcion_12 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_12 = New System.Windows.Forms.Label()
        Me._lblDescripcion_13 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_11 = New System.Windows.Forms.Label()
        Me._lblDescripcion_10 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_11 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._picVisto_0 = New System.Windows.Forms.PictureBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBloqChq = New System.Windows.Forms.ToolStripButton()
        Me.TSBDesChq = New System.Windows.Forms.ToolStripButton()
        Me.TSBAcuse = New System.Windows.Forms.ToolStripButton()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox2.SuspendLayout()
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
        '_picVisto_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_1, False)
        Me._picVisto_1.BackColor = System.Drawing.Color.Silver
        Me._picVisto_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_1, "Default")
        Me._picVisto_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_1.Location = New System.Drawing.Point(555, 0)
        Me._picVisto_1.Name = "_picVisto_1"
        Me._picVisto_1.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_1.TabIndex = 7
        Me._picVisto_1.TabStop = False
        Me._picVisto_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_1, "")
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
        Me._cmdBoton_6.Location = New System.Drawing.Point(643, 314)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 4
        Me._cmdBoton_6.Text = "*&Limpiar"
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
        '
        'txtCarta
        '
        Me.txtCarta.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCarta, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCarta, False)
        Me.txtCarta.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCarta, "Default")
        Me.txtCarta.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCarta.Location = New System.Drawing.Point(125, 10)
        Me.txtCarta.MaxLength = 9
        Me.txtCarta.Name = "txtCarta"
        Me.txtCarta.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCarta.Size = New System.Drawing.Size(107, 20)
        Me.txtCarta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCarta, "")
        '
        'grdRegistros
        '
        Me.grdRegistros._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRegistros, False)
        Me.grdRegistros.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdRegistros.Clip = ""
        Me.grdRegistros.Col = CType(1, Short)
        Me.grdRegistros.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdRegistros, "Default")
        Me.grdRegistros.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdRegistros, True)
        Me.grdRegistros.FixedCols = CType(1, Short)
        Me.grdRegistros.FixedRows = CType(1, Short)
        Me.grdRegistros.ForeColor = System.Drawing.Color.Black
        Me.grdRegistros.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdRegistros.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdRegistros.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRegistros.HighLight = True
        Me.grdRegistros.Location = New System.Drawing.Point(5, 17)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(576, 229)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 8
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(643, 365)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 5
        Me._cmdBoton_4.Text = "*&Salir"
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
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(643, 263)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 3
        Me._cmdBoton_3.Text = "*&Buscar"
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(644, 115)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 2
        Me._cmdBoton_2.Text = "*&Des. Chq"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(643, 64)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 1
        Me._cmdBoton_0.Text = "*&Bloq. Chq"
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(643, 211)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 30
        Me._cmdBoton_1.Text = "*&Acuse"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_lblDescripcion_17
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_17, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_17, False)
        Me._lblDescripcion_17.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_17.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_17, "Default")
        Me._lblDescripcion_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_17.Location = New System.Drawing.Point(416, 9)
        Me._lblDescripcion_17.Name = "_lblDescripcion_17"
        Me._lblDescripcion_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_17.Size = New System.Drawing.Size(167, 20)
        Me._lblDescripcion_17.TabIndex = 44
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_17, "")
        '
        '_lblEtiqueta_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_16, False)
        Me._lblEtiqueta_16.AutoSize = True
        Me._lblEtiqueta_16.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_16, "Default")
        Me._lblEtiqueta_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_16.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_16.Location = New System.Drawing.Point(290, 38)
        Me._lblEtiqueta_16.Name = "_lblEtiqueta_16"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_16, "5155")
        Me._lblEtiqueta_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_16.Size = New System.Drawing.Size(51, 13)
        Me._lblEtiqueta_16.TabIndex = 43
        Me._lblEtiqueta_16.Text = "*Causa:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_16, "")
        '
        '_lblDescripcion_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_16, False)
        Me._lblDescripcion_16.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_16.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_16, "Default")
        Me._lblDescripcion_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_16.Location = New System.Drawing.Point(416, 33)
        Me._lblDescripcion_16.Name = "_lblDescripcion_16"
        Me._lblDescripcion_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_16.Size = New System.Drawing.Size(167, 20)
        Me._lblDescripcion_16.TabIndex = 42
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_16, "")
        '
        '_lblDescripcion_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_15, False)
        Me._lblDescripcion_15.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_15.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_15, "Default")
        Me._lblDescripcion_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_15.Location = New System.Drawing.Point(125, 35)
        Me._lblDescripcion_15.Name = "_lblDescripcion_15"
        Me._lblDescripcion_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_15.Size = New System.Drawing.Size(107, 20)
        Me._lblDescripcion_15.TabIndex = 41
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_15, "")
        '
        '_lblEtiqueta_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_15, False)
        Me._lblEtiqueta_15.AutoSize = True
        Me._lblEtiqueta_15.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_15, "Default")
        Me._lblEtiqueta_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_15.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_15.Location = New System.Drawing.Point(290, 9)
        Me._lblEtiqueta_15.Name = "_lblEtiqueta_15"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_15, "5067")
        Me._lblEtiqueta_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_15.Size = New System.Drawing.Size(55, 13)
        Me._lblEtiqueta_15.TabIndex = 40
        Me._lblEtiqueta_15.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_15, "")
        '
        '_lblEtiqueta_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_14, False)
        Me._lblEtiqueta_14.AutoSize = True
        Me._lblEtiqueta_14.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_14, "Default")
        Me._lblEtiqueta_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_14.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_14.Location = New System.Drawing.Point(13, 37)
        Me._lblEtiqueta_14.Name = "_lblEtiqueta_14"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_14, "500030")
        Me._lblEtiqueta_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_14.Size = New System.Drawing.Size(45, 13)
        Me._lblEtiqueta_14.TabIndex = 39
        Me._lblEtiqueta_14.Text = "*Valor:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_14, "")
        '
        '_lblDescripcion_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_14, False)
        Me._lblDescripcion_14.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_14.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_14, "Default")
        Me._lblDescripcion_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_14.Location = New System.Drawing.Point(125, 12)
        Me._lblDescripcion_14.Name = "_lblDescripcion_14"
        Me._lblDescripcion_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_14.Size = New System.Drawing.Size(107, 20)
        Me._lblDescripcion_14.TabIndex = 38
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_14, "")
        '
        '_lblEtiqueta_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_13, False)
        Me._lblEtiqueta_13.AutoSize = True
        Me._lblEtiqueta_13.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_13, "Default")
        Me._lblEtiqueta_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_13.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_13.Location = New System.Drawing.Point(13, 11)
        Me._lblEtiqueta_13.Name = "_lblEtiqueta_13"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_13, "508454")
        Me._lblEtiqueta_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_13.Size = New System.Drawing.Size(59, 13)
        Me._lblEtiqueta_13.TabIndex = 37
        Me._lblEtiqueta_13.Text = "*Cheque:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_13, "")
        '
        '_lblDescripcion_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_12, False)
        Me._lblDescripcion_12.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_12.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_12, "Default")
        Me._lblDescripcion_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_12.Location = New System.Drawing.Point(125, 55)
        Me._lblDescripcion_12.Name = "_lblDescripcion_12"
        Me._lblDescripcion_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_12.Size = New System.Drawing.Size(137, 20)
        Me._lblDescripcion_12.TabIndex = 36
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_12, "")
        '
        '_lblEtiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_12, False)
        Me._lblEtiqueta_12.AutoSize = True
        Me._lblEtiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_12, "Default")
        Me._lblEtiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_12.Location = New System.Drawing.Point(290, 11)
        Me._lblEtiqueta_12.Name = "_lblEtiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_12, "5048")
        Me._lblEtiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_12.Size = New System.Drawing.Size(67, 13)
        Me._lblEtiqueta_12.TabIndex = 35
        Me._lblEtiqueta_12.Text = "*Producto:"
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
        Me._lblDescripcion_13.Location = New System.Drawing.Point(415, 10)
        Me._lblDescripcion_13.Name = "_lblDescripcion_13"
        Me._lblDescripcion_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_13.Size = New System.Drawing.Size(167, 20)
        Me._lblDescripcion_13.TabIndex = 34
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_13, "")
        '
        '_lblEtiqueta_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_11, False)
        Me._lblEtiqueta_11.AutoSize = True
        Me._lblEtiqueta_11.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_11, "Default")
        Me._lblEtiqueta_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_11.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_11.Location = New System.Drawing.Point(10, 57)
        Me._lblEtiqueta_11.Name = "_lblEtiqueta_11"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_11, "508487")
        Me._lblEtiqueta_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_11.Size = New System.Drawing.Size(103, 13)
        Me._lblEtiqueta_11.TabIndex = 33
        Me._lblEtiqueta_11.Text = "*Cta Depositada:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_11, "")
        '
        '_lblDescripcion_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_10, False)
        Me._lblDescripcion_10.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_10.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_10, "Default")
        Me._lblDescripcion_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_10.Location = New System.Drawing.Point(125, 33)
        Me._lblDescripcion_10.Name = "_lblDescripcion_10"
        Me._lblDescripcion_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_10.Size = New System.Drawing.Size(137, 20)
        Me._lblDescripcion_10.TabIndex = 32
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_10, "")
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
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(10, 32)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "2506")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(76, 13)
        Me._lblEtiqueta_10.TabIndex = 31
        Me._lblEtiqueta_10.Text = "*Cta Girada:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        '_lblDescripcion_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_11, False)
        Me._lblDescripcion_11.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_11.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_11, "Default")
        Me._lblDescripcion_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_11.Location = New System.Drawing.Point(416, 9)
        Me._lblDescripcion_11.Name = "_lblDescripcion_11"
        Me._lblDescripcion_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_11.Size = New System.Drawing.Size(167, 20)
        Me._lblDescripcion_11.TabIndex = 29
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_11, "")
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
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(290, 10)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "500299")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(130, 13)
        Me._lblEtiqueta_8.TabIndex = 28
        Me._lblEtiqueta_8.Text = "*Fecha emisión carta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
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
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "500300")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(87, 13)
        Me._lblEtiqueta_7.TabIndex = 27
        Me._lblEtiqueta_7.Text = "*No. de carta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblDescripcion_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_9, False)
        Me._lblDescripcion_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_9, "Default")
        Me._lblDescripcion_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_9.Location = New System.Drawing.Point(415, 10)
        Me._lblDescripcion_9.Name = "_lblDescripcion_9"
        Me._lblDescripcion_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_9.Size = New System.Drawing.Size(167, 20)
        Me._lblDescripcion_9.TabIndex = 25
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_9, "")
        '
        '_lblDescripcion_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_8, False)
        Me._lblDescripcion_8.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_8.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_8, "Default")
        Me._lblDescripcion_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_8.Location = New System.Drawing.Point(125, 35)
        Me._lblDescripcion_8.Name = "_lblDescripcion_8"
        Me._lblDescripcion_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_8.Size = New System.Drawing.Size(107, 20)
        Me._lblDescripcion_8.TabIndex = 24
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_8, "")
        '
        '_lblDescripcion_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_7, False)
        Me._lblDescripcion_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_7, "Default")
        Me._lblDescripcion_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_7.Location = New System.Drawing.Point(416, 33)
        Me._lblDescripcion_7.Name = "_lblDescripcion_7"
        Me._lblDescripcion_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_7.Size = New System.Drawing.Size(167, 20)
        Me._lblDescripcion_7.TabIndex = 23
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
        Me._lblDescripcion_6.Location = New System.Drawing.Point(125, 12)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(107, 20)
        Me._lblDescripcion_6.TabIndex = 22
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_6, "")
        '
        '_lblDescripcion_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_5, False)
        Me._lblDescripcion_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_5, "Default")
        Me._lblDescripcion_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_5.Location = New System.Drawing.Point(263, 55)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(320, 20)
        Me._lblDescripcion_5.TabIndex = 21
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
        Me._lblDescripcion_4.Location = New System.Drawing.Point(125, 55)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(137, 20)
        Me._lblDescripcion_4.TabIndex = 20
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
        Me._lblDescripcion_3.Location = New System.Drawing.Point(263, 58)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(320, 20)
        Me._lblDescripcion_3.TabIndex = 19
        Me._lblDescripcion_3.Visible = False
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
        Me._lblDescripcion_2.Location = New System.Drawing.Point(125, 58)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(137, 20)
        Me._lblDescripcion_2.TabIndex = 18
        Me._lblDescripcion_2.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(263, 33)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(320, 20)
        Me._lblDescripcion_1.TabIndex = 17
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
        Me._lblDescripcion_0.Location = New System.Drawing.Point(125, 33)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(137, 20)
        Me._lblDescripcion_0.TabIndex = 16
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
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
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(290, 10)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500301")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(110, 13)
        Me._lblEtiqueta_6.TabIndex = 15
        Me._lblEtiqueta_6.Text = "*Valor de la carta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
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
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 37)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "500302")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(106, 13)
        Me._lblEtiqueta_5.TabIndex = 14
        Me._lblEtiqueta_5.Text = "*No. de cheques:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
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
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(290, 38)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "500303")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(101, 13)
        Me._lblEtiqueta_4.TabIndex = 13
        Me._lblEtiqueta_4.Text = "*Fecha efectiva:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
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
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 12)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "2315")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(100, 13)
        Me._lblEtiqueta_3.TabIndex = 12
        Me._lblEtiqueta_3.Text = "*Días retención:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
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
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 58)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "500336")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(53, 13)
        Me._lblEtiqueta_2.TabIndex = 11
        Me._lblEtiqueta_2.Text = "*Emisor:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
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
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 57)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "500335")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(77, 13)
        Me._lblEtiqueta_1.TabIndex = 10
        Me._lblEtiqueta_1.Text = "*Propietario:"
        Me._lblEtiqueta_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
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
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "500334")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(89, 13)
        Me._lblEtiqueta_0.TabIndex = 9
        Me._lblEtiqueta_0.Text = "*Corresponsal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_picVisto_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_0, False)
        Me._picVisto_0.BackColor = System.Drawing.Color.Gray
        Me._picVisto_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_0, "Default")
        Me._picVisto_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_0.Image = CType(resources.GetObject("_picVisto_0.Image"), System.Drawing.Image)
        Me._picVisto_0.Location = New System.Drawing.Point(540, 0)
        Me._picVisto_0.Name = "_picVisto_0"
        Me._picVisto_0.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_0.TabIndex = 6
        Me._picVisto_0.TabStop = False
        Me._picVisto_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_0, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdRegistros)
        Me.GroupBox1.Controls.Add(Me._picVisto_0)
        Me.GroupBox1.Controls.Add(Me._picVisto_1)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 194)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(599, 252)
        Me.GroupBox1.TabIndex = 46
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox2)
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(624, 465)
        Me.PFormas.TabIndex = 47
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_16)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_8)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_15)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_16)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_7)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_4)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_17)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_11)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_3)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_9)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_5)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_13)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_2)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_14)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_3)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_1)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_6)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_8)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_14)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_15)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.Location = New System.Drawing.Point(10, 102)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.UltraGroupBox2.Size = New System.Drawing.Size(599, 88)
        Me.UltraGroupBox2.TabIndex = 49
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
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
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(10, 58)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "500298")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(113, 13)
        Me._lblEtiqueta_9.TabIndex = 47
        Me._lblEtiqueta_9.Text = "*Lista de cheques:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_6)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_11)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_10)
        Me.UltraGroupBox1.Controls.Add(Me.txtCarta)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_12)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_13)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_7)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_9)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_5)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_1)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_12)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_10)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_0)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_4)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(599, 85)
        Me.UltraGroupBox1.TabIndex = 48
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBloqChq, Me.TSBDesChq, Me.TSBAcuse, Me.TSBBuscar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(644, 25)
        Me.TSBotones.TabIndex = 48
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBloqChq
        '
        Me.TSBBloqChq.ForeColor = System.Drawing.Color.Navy
        Me.TSBBloqChq.Image = CType(resources.GetObject("TSBBloqChq.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBloqChq, "2501")
        Me.TSBBloqChq.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBloqChq.Name = "TSBBloqChq"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBloqChq, "508426")
        Me.TSBBloqChq.Size = New System.Drawing.Size(84, 22)
        Me.TSBBloqChq.Text = "*&Bloq. Chq"
        '
        'TSBDesChq
        '
        Me.TSBDesChq.ForeColor = System.Drawing.Color.Navy
        Me.TSBDesChq.Image = CType(resources.GetObject("TSBDesChq.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBDesChq, "2503")
        Me.TSBDesChq.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBDesChq.Name = "TSBDesChq"
        Me.COBISResourceProvider.SetResourceID(Me.TSBDesChq, "508427")
        Me.TSBDesChq.Size = New System.Drawing.Size(79, 22)
        Me.TSBDesChq.Text = "*&Des. Chq"
        '
        'TSBAcuse
        '
        Me.TSBAcuse.ForeColor = System.Drawing.Color.Navy
        Me.TSBAcuse.Image = CType(resources.GetObject("TSBAcuse.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBAcuse, "2064")
        Me.TSBAcuse.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBAcuse.Name = "TSBAcuse"
        Me.COBISResourceProvider.SetResourceID(Me.TSBAcuse, "508425")
        Me.TSBAcuse.Size = New System.Drawing.Size(64, 22)
        Me.TSBAcuse.Text = "*&Acuse"
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Navy
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Navy
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
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FTran602Class
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
        Me.Location = New System.Drawing.Point(37, 124)
        Me.Name = "FTran602Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(644, 526)
        Me.Tag = "3889"
        Me.Text = "*Novedades de Remesa"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox2.ResumeLayout(False)
        Me.UltraGroupBox2.PerformLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializepicVisto()
        Me.picVisto(0) = _picVisto_0
        Me.picVisto(1) = _picVisto_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(16) = _lblEtiqueta_16
        Me.lblEtiqueta(15) = _lblEtiqueta_15
        Me.lblEtiqueta(14) = _lblEtiqueta_14
        Me.lblEtiqueta(13) = _lblEtiqueta_13
        Me.lblEtiqueta(12) = _lblEtiqueta_12
        Me.lblEtiqueta(11) = _lblEtiqueta_11
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(17) = _lblDescripcion_17
        Me.lblDescripcion(16) = _lblDescripcion_16
        Me.lblDescripcion(15) = _lblDescripcion_15
        Me.lblDescripcion(14) = _lblDescripcion_14
        Me.lblDescripcion(12) = _lblDescripcion_12
        Me.lblDescripcion(13) = _lblDescripcion_13
        Me.lblDescripcion(10) = _lblDescripcion_10
        Me.lblDescripcion(11) = _lblDescripcion_11
        Me.lblDescripcion(9) = _lblDescripcion_9
        Me.lblDescripcion(8) = _lblDescripcion_8
        Me.lblDescripcion(7) = _lblDescripcion_7
        Me.lblDescripcion(6) = _lblDescripcion_6
        Me.lblDescripcion(5) = _lblDescripcion_5
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(6) = _cmdBoton_6
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
    End Sub
    Private WithEvents _picVisto_0 As System.Windows.Forms.PictureBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBloqChq As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBDesChq As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBAcuse As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


