<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FRTACIFINClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		Initializelbletiqueta()
		InitializelblDescripcion()
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
    Public WithEvents cmdSalir As System.Windows.Forms.Button
    Private WithEvents _lbletiqueta_17 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_17 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_16 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_16 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_15 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_14 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_13 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_12 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_11 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_15 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_14 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_13 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_11 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
	Public lblDescripcion(17) As System.Windows.Forms.Label
	Public lbletiqueta(17) As System.Windows.Forms.Label
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FRTACIFINClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.cmdSalir = New System.Windows.Forms.Button()
        Me._lbletiqueta_17 = New System.Windows.Forms.Label()
        Me._lblDescripcion_17 = New System.Windows.Forms.Label()
        Me._lbletiqueta_16 = New System.Windows.Forms.Label()
        Me._lblDescripcion_16 = New System.Windows.Forms.Label()
        Me._lblDescripcion_15 = New System.Windows.Forms.Label()
        Me._lblDescripcion_14 = New System.Windows.Forms.Label()
        Me._lblDescripcion_13 = New System.Windows.Forms.Label()
        Me._lblDescripcion_12 = New System.Windows.Forms.Label()
        Me._lblDescripcion_11 = New System.Windows.Forms.Label()
        Me._lblDescripcion_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lbletiqueta_15 = New System.Windows.Forms.Label()
        Me._lbletiqueta_14 = New System.Windows.Forms.Label()
        Me._lbletiqueta_13 = New System.Windows.Forms.Label()
        Me._lbletiqueta_12 = New System.Windows.Forms.Label()
        Me._lbletiqueta_11 = New System.Windows.Forms.Label()
        Me._lbletiqueta_10 = New System.Windows.Forms.Label()
        Me._lbletiqueta_9 = New System.Windows.Forms.Label()
        Me._lbletiqueta_8 = New System.Windows.Forms.Label()
        Me._lbletiqueta_7 = New System.Windows.Forms.Label()
        Me._lbletiqueta_6 = New System.Windows.Forms.Label()
        Me._lbletiqueta_5 = New System.Windows.Forms.Label()
        Me._lbletiqueta_4 = New System.Windows.Forms.Label()
        Me._lbletiqueta_3 = New System.Windows.Forms.Label()
        Me._lbletiqueta_2 = New System.Windows.Forms.Label()
        Me._lbletiqueta_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox2.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        Me.TSBBotones.SuspendLayout()
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
        'cmdSalir
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdSalir, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdSalir, False)
        Me.cmdSalir.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdSalir, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdSalir, True)
        Me.cmdSalir.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdSalir, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdSalir, Nothing)
        Me.cmdSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSalir.Location = New System.Drawing.Point(-570, 322)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSalir, System.Drawing.Color.Silver)
        Me.cmdSalir.Name = "cmdSalir"
        Me.cmdSalir.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSalir.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me.cmdSalir, 1)
        Me.cmdSalir.TabIndex = 0
        Me.cmdSalir.Text = "*&Salir"
        Me.cmdSalir.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSalir.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSalir, "")
        '
        '_lbletiqueta_17
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_17, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_17, False)
        Me._lbletiqueta_17.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_17, "Default")
        Me._lbletiqueta_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_17.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_17.Location = New System.Drawing.Point(301, 20)
        Me._lbletiqueta_17.Name = "_lbletiqueta_17"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_17, "2418")
        Me._lbletiqueta_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_17.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_17.TabIndex = 36
        Me._lbletiqueta_17.Text = "*Fecha Fin Exención:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_17, "")
        '
        '_lblDescripcion_17
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_17, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_17, False)
        Me._lblDescripcion_17.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_17.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_17, "Default")
        Me._lblDescripcion_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_17.Location = New System.Drawing.Point(437, 20)
        Me._lblDescripcion_17.Name = "_lblDescripcion_17"
        Me._lblDescripcion_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_17.Size = New System.Drawing.Size(131, 20)
        Me._lblDescripcion_17.TabIndex = 16
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_17, "")
        '
        '_lbletiqueta_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_16, False)
        Me._lbletiqueta_16.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_16, "Default")
        Me._lbletiqueta_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_16.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_16.Location = New System.Drawing.Point(10, 20)
        Me._lbletiqueta_16.Name = "_lbletiqueta_16"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_16, "2415")
        Me._lbletiqueta_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_16.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_16.TabIndex = 34
        Me._lbletiqueta_16.Text = "*Fecha Ini Exención:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_16, "")
        '
        '_lblDescripcion_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_16, False)
        Me._lblDescripcion_16.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_16.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_16, "Default")
        Me._lblDescripcion_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_16.Location = New System.Drawing.Point(149, 20)
        Me._lblDescripcion_16.Name = "_lblDescripcion_16"
        Me._lblDescripcion_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_16.Size = New System.Drawing.Size(131, 20)
        Me._lblDescripcion_16.TabIndex = 7
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
        Me._lblDescripcion_15.Location = New System.Drawing.Point(149, 204)
        Me._lblDescripcion_15.Name = "_lblDescripcion_15"
        Me._lblDescripcion_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_15.Size = New System.Drawing.Size(419, 20)
        Me._lblDescripcion_15.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_15, "")
        '
        '_lblDescripcion_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_14, False)
        Me._lblDescripcion_14.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_14.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_14, "Default")
        Me._lblDescripcion_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_14.Location = New System.Drawing.Point(149, 181)
        Me._lblDescripcion_14.Name = "_lblDescripcion_14"
        Me._lblDescripcion_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_14.Size = New System.Drawing.Size(419, 20)
        Me._lblDescripcion_14.TabIndex = 14
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_14, "")
        '
        '_lblDescripcion_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_13, False)
        Me._lblDescripcion_13.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_13.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_13, "Default")
        Me._lblDescripcion_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_13.Location = New System.Drawing.Point(149, 158)
        Me._lblDescripcion_13.Name = "_lblDescripcion_13"
        Me._lblDescripcion_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_13.Size = New System.Drawing.Size(219, 20)
        Me._lblDescripcion_13.TabIndex = 13
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_13, "")
        '
        '_lblDescripcion_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_12, False)
        Me._lblDescripcion_12.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_12.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_12, "Default")
        Me._lblDescripcion_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_12.Location = New System.Drawing.Point(149, 135)
        Me._lblDescripcion_12.Name = "_lblDescripcion_12"
        Me._lblDescripcion_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_12.Size = New System.Drawing.Size(219, 20)
        Me._lblDescripcion_12.TabIndex = 12
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_12, "")
        '
        '_lblDescripcion_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_11, False)
        Me._lblDescripcion_11.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_11.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_11, "Default")
        Me._lblDescripcion_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_11.Location = New System.Drawing.Point(149, 112)
        Me._lblDescripcion_11.Name = "_lblDescripcion_11"
        Me._lblDescripcion_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_11.Size = New System.Drawing.Size(219, 20)
        Me._lblDescripcion_11.TabIndex = 11
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
        Me._lblDescripcion_10.Location = New System.Drawing.Point(149, 89)
        Me._lblDescripcion_10.Name = "_lblDescripcion_10"
        Me._lblDescripcion_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_10.Size = New System.Drawing.Size(219, 20)
        Me._lblDescripcion_10.TabIndex = 10
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_10, "")
        '
        '_lblDescripcion_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_9, False)
        Me._lblDescripcion_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_9, "Default")
        Me._lblDescripcion_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_9.Location = New System.Drawing.Point(149, 66)
        Me._lblDescripcion_9.Name = "_lblDescripcion_9"
        Me._lblDescripcion_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_9.Size = New System.Drawing.Size(419, 20)
        Me._lblDescripcion_9.TabIndex = 9
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
        Me._lblDescripcion_8.Location = New System.Drawing.Point(149, 43)
        Me._lblDescripcion_8.Name = "_lblDescripcion_8"
        Me._lblDescripcion_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_8.Size = New System.Drawing.Size(219, 20)
        Me._lblDescripcion_8.TabIndex = 8
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
        Me._lblDescripcion_7.Location = New System.Drawing.Point(149, 135)
        Me._lblDescripcion_7.Name = "_lblDescripcion_7"
        Me._lblDescripcion_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_7.Size = New System.Drawing.Size(419, 20)
        Me._lblDescripcion_7.TabIndex = 6
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
        Me._lblDescripcion_6.Location = New System.Drawing.Point(149, 112)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(419, 20)
        Me._lblDescripcion_6.TabIndex = 5
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
        Me._lblDescripcion_5.Location = New System.Drawing.Point(149, 89)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(131, 20)
        Me._lblDescripcion_5.TabIndex = 4
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
        Me._lblDescripcion_4.Location = New System.Drawing.Point(149, 66)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(419, 20)
        Me._lblDescripcion_4.TabIndex = 3
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
        Me._lblDescripcion_3.Location = New System.Drawing.Point(149, 43)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(419, 20)
        Me._lblDescripcion_3.TabIndex = 2
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
        Me._lblDescripcion_2.Location = New System.Drawing.Point(437, 20)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(131, 20)
        Me._lblDescripcion_2.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lbletiqueta_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_15, False)
        Me._lbletiqueta_15.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_15, "Default")
        Me._lbletiqueta_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_15.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_15.Location = New System.Drawing.Point(10, 204)
        Me._lbletiqueta_15.Name = "_lbletiqueta_15"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_15, "2422")
        Me._lbletiqueta_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_15.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_15.TabIndex = 17
        Me._lbletiqueta_15.Text = "*Concepto Exención:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_15, "")
        '
        '_lbletiqueta_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_14, False)
        Me._lbletiqueta_14.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_14, "Default")
        Me._lbletiqueta_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_14.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_14.Location = New System.Drawing.Point(10, 181)
        Me._lbletiqueta_14.Name = "_lbletiqueta_14"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_14, "500366")
        Me._lbletiqueta_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_14.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_14.TabIndex = 16
        Me._lbletiqueta_14.Text = "*Usuario:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_14, "")
        '
        '_lbletiqueta_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_13, False)
        Me._lbletiqueta_13.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_13, "Default")
        Me._lbletiqueta_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_13.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_13.Location = New System.Drawing.Point(10, 158)
        Me._lbletiqueta_13.Name = "_lbletiqueta_13"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_13, "2421")
        Me._lbletiqueta_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_13.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_13.TabIndex = 15
        Me._lbletiqueta_13.Text = "*Estado de Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_13, "")
        '
        '_lbletiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_12, False)
        Me._lbletiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_12, "Default")
        Me._lbletiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_12.Location = New System.Drawing.Point(10, 135)
        Me._lbletiqueta_12.Name = "_lbletiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_12, "500727")
        Me._lbletiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_12.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_12.TabIndex = 14
        Me._lbletiqueta_12.Text = "*Tipo de Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_12, "")
        '
        '_lbletiqueta_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_11, False)
        Me._lbletiqueta_11.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_11, "Default")
        Me._lbletiqueta_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_11.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_11.Location = New System.Drawing.Point(10, 112)
        Me._lbletiqueta_11.Name = "_lbletiqueta_11"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_11, "2420")
        Me._lbletiqueta_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_11.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_11.TabIndex = 13
        Me._lbletiqueta_11.Text = "*Oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_11, "")
        '
        '_lbletiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_10, False)
        Me._lbletiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_10, "Default")
        Me._lbletiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_10.Location = New System.Drawing.Point(10, 89)
        Me._lbletiqueta_10.Name = "_lbletiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_10, "2419")
        Me._lbletiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_10.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_10.TabIndex = 12
        Me._lbletiqueta_10.Text = "*Nro. de Cuenta"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_10, "")
        '
        '_lbletiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_9, False)
        Me._lbletiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_9, "Default")
        Me._lbletiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_9.Location = New System.Drawing.Point(10, 66)
        Me._lbletiqueta_9.Name = "_lbletiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_9, "2417")
        Me._lbletiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_9.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_9.TabIndex = 11
        Me._lbletiqueta_9.Text = "*Nombre de Entidad:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_9, "")
        '
        '_lbletiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_8, False)
        Me._lbletiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_8, "Default")
        Me._lbletiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_8.Location = New System.Drawing.Point(10, 43)
        Me._lbletiqueta_8.Name = "_lbletiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_8, "2416")
        Me._lbletiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_8.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_8.TabIndex = 10
        Me._lbletiqueta_8.Text = "*Tipo de Entidad:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_8, "")
        '
        '_lbletiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_7, False)
        Me._lbletiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_7, "Default")
        Me._lbletiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_7.Location = New System.Drawing.Point(10, 135)
        Me._lbletiqueta_7.Name = "_lbletiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_7, "2413")
        Me._lbletiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_7.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_7.TabIndex = 9
        Me._lbletiqueta_7.Text = "*Mensaje de Exención:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_7, "")
        '
        '_lbletiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_6, False)
        Me._lbletiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_6, "Default")
        Me._lbletiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_6.Location = New System.Drawing.Point(10, 112)
        Me._lbletiqueta_6.Name = "_lbletiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_6, "2412")
        Me._lbletiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_6.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_6.TabIndex = 8
        Me._lbletiqueta_6.Text = "*Lugar Expedición Id:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_6, "")
        '
        '_lbletiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_5, False)
        Me._lbletiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_5, "Default")
        Me._lbletiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_5.Location = New System.Drawing.Point(10, 89)
        Me._lbletiqueta_5.Name = "_lbletiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_5, "2411")
        Me._lbletiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_5.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_5.TabIndex = 7
        Me._lbletiqueta_5.Text = "*Fecha Expedición Id:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_5, "")
        '
        '_lbletiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_4, False)
        Me._lbletiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_4, "Default")
        Me._lbletiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_4.Location = New System.Drawing.Point(10, 66)
        Me._lbletiqueta_4.Name = "_lbletiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_4, "2410")
        Me._lbletiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_4.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_4.TabIndex = 6
        Me._lbletiqueta_4.Text = "*Estado Identificación:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_4, "")
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
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_3, "5095")
        Me._lbletiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_3.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_3.TabIndex = 5
        Me._lbletiqueta_3.Text = "*Nombre del Cliente:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_3, "")
        '
        '_lbletiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_2, False)
        Me._lbletiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_2, "Default")
        Me._lbletiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_2.Location = New System.Drawing.Point(301, 20)
        Me._lbletiqueta_2.Name = "_lbletiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_2, "2404")
        Me._lbletiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_2.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_2.TabIndex = 4
        Me._lbletiqueta_2.Text = "*Nro. Identificación:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_2, "")
        '
        '_lbletiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_1, False)
        Me._lbletiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_1, "Default")
        Me._lbletiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_1.Location = New System.Drawing.Point(10, 20)
        Me._lbletiqueta_1.Name = "_lbletiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_1, "2409")
        Me._lbletiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_1.Size = New System.Drawing.Size(126, 20)
        Me._lbletiqueta_1.TabIndex = 3
        Me._lbletiqueta_1.Text = "*Tipo de Identificación:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_1, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(149, 20)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(131, 20)
        Me._lblDescripcion_1.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox2)
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me.cmdSalir)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(608, 429)
        Me.PFormas.TabIndex = 37
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox2.Controls.Add(Me._lbletiqueta_16)
        Me.UltraGroupBox2.Controls.Add(Me._lbletiqueta_15)
        Me.UltraGroupBox2.Controls.Add(Me._lbletiqueta_14)
        Me.UltraGroupBox2.Controls.Add(Me._lbletiqueta_17)
        Me.UltraGroupBox2.Controls.Add(Me._lbletiqueta_13)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_17)
        Me.UltraGroupBox2.Controls.Add(Me._lbletiqueta_12)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_8)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_16)
        Me.UltraGroupBox2.Controls.Add(Me._lbletiqueta_11)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_15)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_9)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_14)
        Me.UltraGroupBox2.Controls.Add(Me._lbletiqueta_10)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_13)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_10)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_12)
        Me.UltraGroupBox2.Controls.Add(Me._lbletiqueta_9)
        Me.UltraGroupBox2.Controls.Add(Me._lbletiqueta_8)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_11)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox2.Location = New System.Drawing.Point(10, 183)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.COBISResourceProvider.SetResourceID(Me.UltraGroupBox2, "2414")
        Me.UltraGroupBox2.Size = New System.Drawing.Size(588, 235)
        Me.UltraGroupBox2.TabIndex = 38
        Me.UltraGroupBox2.Text = "*INFORMACIÓN DE CUENTAS Y EXENCIONES"
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_3)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_1)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_4)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_5)
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_1)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_6)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_7)
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_7)
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_6)
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_3)
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_5)
        Me.UltraGroupBox1.Controls.Add(Me._lbletiqueta_4)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.UltraGroupBox1, "2408")
        Me.UltraGroupBox1.Size = New System.Drawing.Size(588, 168)
        Me.UltraGroupBox1.TabIndex = 37
        Me.UltraGroupBox1.Text = "*INFORMACIÓN GENERAL DEL CLIENTE"
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'TSBBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBBotones, "Default")
        Me.TSBBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBSalir})
        Me.TSBBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBBotones.Name = "TSBBotones"
        Me.TSBBotones.Size = New System.Drawing.Size(628, 25)
        Me.TSBBotones.TabIndex = 38
        Me.TSBBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBBotones, "")
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FRTACIFINClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(4, 116)
        Me.Name = "FRTACIFINClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(628, 475)
        Me.Text = "Respuesta CIFIN - GMF"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox2.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.TSBBotones.ResumeLayout(False)
        Me.TSBBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub Initializelbletiqueta()
        Me.lbletiqueta(17) = _lbletiqueta_17
        Me.lbletiqueta(16) = _lbletiqueta_16
        Me.lbletiqueta(15) = _lbletiqueta_15
        Me.lbletiqueta(14) = _lbletiqueta_14
        Me.lbletiqueta(13) = _lbletiqueta_13
        Me.lbletiqueta(12) = _lbletiqueta_12
        Me.lbletiqueta(11) = _lbletiqueta_11
        Me.lbletiqueta(10) = _lbletiqueta_10
        Me.lbletiqueta(9) = _lbletiqueta_9
        Me.lbletiqueta(8) = _lbletiqueta_8
        Me.lbletiqueta(7) = _lbletiqueta_7
        Me.lbletiqueta(6) = _lbletiqueta_6
        Me.lbletiqueta(5) = _lbletiqueta_5
        Me.lbletiqueta(4) = _lbletiqueta_4
        Me.lbletiqueta(3) = _lbletiqueta_3
        Me.lbletiqueta(2) = _lbletiqueta_2
        Me.lbletiqueta(1) = _lbletiqueta_1
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(17) = _lblDescripcion_17
        Me.lblDescripcion(16) = _lblDescripcion_16
        Me.lblDescripcion(15) = _lblDescripcion_15
        Me.lblDescripcion(14) = _lblDescripcion_14
        Me.lblDescripcion(13) = _lblDescripcion_13
        Me.lblDescripcion(12) = _lblDescripcion_12
        Me.lblDescripcion(11) = _lblDescripcion_11
        Me.lblDescripcion(10) = _lblDescripcion_10
        Me.lblDescripcion(9) = _lblDescripcion_9
        Me.lblDescripcion(8) = _lblDescripcion_8
        Me.lblDescripcion(7) = _lblDescripcion_7
        Me.lblDescripcion(6) = _lblDescripcion_6
        Me.lblDescripcion(5) = _lblDescripcion_5
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
    End Sub
    'Sub InitializeLine1()
    '   Me.Line1(1) = _Line1_1
    '    Me.Line1(0) = _Line1_0
    'End Sub
    ' Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


