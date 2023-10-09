Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FArchTransfClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtCampo()
		Initializelbletiqueta()
		InitializelblValor()
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
    Public WithEvents MskFecha As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Public WithEvents txtCliente As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Public WithEvents grdDetalle As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _lblValor_8 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_11 As System.Windows.Forms.Label
    Private WithEvents _lblValor_7 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblValor_6 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblValor_4 As System.Windows.Forms.Label
    Private WithEvents _lblValor_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblValor_3 As System.Windows.Forms.Label
    Private WithEvents _lblValor_2 As System.Windows.Forms.Label
    Private WithEvents _lblValor_1 As System.Windows.Forms.Label
    Private WithEvents _lblValor_0 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_1 As System.Windows.Forms.Label
    Public Line1(3) As System.Windows.Forms.Label
    Public cmdBoton(3) As System.Windows.Forms.Button
    Public lblDescripcion(3) As System.Windows.Forms.Label
    Public lblValor(8) As System.Windows.Forms.Label
    Public lbletiqueta(12) As System.Windows.Forms.Label
    Public txtCampo(1) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FArchTransfClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.MskFecha = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me.txtCliente = New System.Windows.Forms.TextBox()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me.grdDetalle = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._lblValor_8 = New System.Windows.Forms.Label()
        Me._lbletiqueta_12 = New System.Windows.Forms.Label()
        Me._lbletiqueta_11 = New System.Windows.Forms.Label()
        Me._lblValor_7 = New System.Windows.Forms.Label()
        Me._lbletiqueta_8 = New System.Windows.Forms.Label()
        Me._lblValor_6 = New System.Windows.Forms.Label()
        Me._lbletiqueta_6 = New System.Windows.Forms.Label()
        Me._lbletiqueta_10 = New System.Windows.Forms.Label()
        Me._lblValor_4 = New System.Windows.Forms.Label()
        Me._lblValor_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblValor_3 = New System.Windows.Forms.Label()
        Me._lblValor_2 = New System.Windows.Forms.Label()
        Me._lblValor_1 = New System.Windows.Forms.Label()
        Me._lblValor_0 = New System.Windows.Forms.Label()
        Me._lbletiqueta_9 = New System.Windows.Forms.Label()
        Me._lbletiqueta_7 = New System.Windows.Forms.Label()
        Me._lbletiqueta_5 = New System.Windows.Forms.Label()
        Me._lbletiqueta_3 = New System.Windows.Forms.Label()
        Me._lbletiqueta_2 = New System.Windows.Forms.Label()
        Me._lbletiqueta_0 = New System.Windows.Forms.Label()
        Me._lbletiqueta_1 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBExcel = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdDetalle, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
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
        'MskFecha
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.MskFecha, False)
        Me.COBISViewResizer.SetAutoResize(Me.MskFecha, False)
        Me.COBISStyleProvider.SetControlStyle(Me.MskFecha, "Default")
        Me.MskFecha.Length = CType(64, Short)
        Me.MskFecha.Location = New System.Drawing.Point(458, 10)
        Me.MskFecha.Mask = "##/##/####"
        Me.MskFecha.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.MskFecha.MaxReal = 3.402823E+38!
        Me.MskFecha.MinReal = -3.402823E+38!
        Me.MskFecha.Name = "MskFecha"
        Me.MskFecha.Size = New System.Drawing.Size(73, 20)
        Me.MskFecha.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me.MskFecha, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Location = New System.Drawing.Point(147, 56)
        Me._txtCampo_1.MaxLength = 0
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.ReadOnly = True
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(472, 20)
        Me._txtCampo_1.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        'txtCliente
        '
        Me.txtCliente.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCliente, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCliente, False)
        Me.txtCliente.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCliente, "Default")
        Me.txtCliente.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCliente.Location = New System.Drawing.Point(147, 10)
        Me.txtCliente.MaxLength = 7
        Me.txtCliente.Name = "txtCliente"
        Me.txtCliente.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCliente.Size = New System.Drawing.Size(64, 20)
        Me.txtCliente.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCliente, "")
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(-777, 203)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 8
        Me._cmdBoton_3.Text = "*&Salir"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-777, 80)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 6
        Me._cmdBoton_1.Text = "*&Excel"
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-777, 23)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 4
        Me._cmdBoton_0.Text = "*&Buscar"
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
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(-777, 135)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 7
        Me._cmdBoton_2.Text = "*&Limpiar"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        'grdDetalle
        '
        Me.grdDetalle._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdDetalle, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdDetalle, False)
        Me.grdDetalle.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdDetalle.Clip = ""
        Me.grdDetalle.Col = CType(1, Short)
        Me.grdDetalle.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdDetalle.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdDetalle.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdDetalle, "Default")
        Me.grdDetalle.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdDetalle, True)
        Me.grdDetalle.FixedCols = CType(1, Short)
        Me.grdDetalle.FixedRows = CType(1, Short)
        Me.grdDetalle.ForeColor = System.Drawing.Color.Black
        Me.grdDetalle.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdDetalle.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdDetalle.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdDetalle.HighLight = True
        Me.grdDetalle.Location = New System.Drawing.Point(6, 71)
        Me.grdDetalle.Name = "grdDetalle"
        Me.grdDetalle.Picture = Nothing
        Me.grdDetalle.Row = CType(1, Short)
        Me.grdDetalle.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdDetalle.Size = New System.Drawing.Size(597, 159)
        Me.grdDetalle.Sort = CType(2, Short)
        Me.grdDetalle.TabIndex = 4
        Me.grdDetalle.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdDetalle, "")
        '
        '_lblValor_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblValor_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblValor_8, False)
        Me._lblValor_8.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblValor_8.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblValor_8, "Default")
        Me._lblValor_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblValor_8.Location = New System.Drawing.Point(147, 171)
        Me._lblValor_8.Name = "_lblValor_8"
        Me._lblValor_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblValor_8.Size = New System.Drawing.Size(472, 20)
        Me._lblValor_8.TabIndex = 32
        Me._lblValor_8.Tag = "2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblValor_8, "")
        '
        '_lbletiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_12, False)
        Me._lbletiqueta_12.AutoSize = True
        Me._lbletiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_12, "Default")
        Me._lbletiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_12.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_12.Location = New System.Drawing.Point(10, 171)
        Me._lbletiqueta_12.Name = "_lbletiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_12, "508632")
        Me._lbletiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_12.Size = New System.Drawing.Size(63, 13)
        Me._lbletiqueta_12.TabIndex = 31
        Me._lbletiqueta_12.Text = "*Mensaje:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_12, "")
        '
        '_lbletiqueta_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_11, False)
        Me._lbletiqueta_11.AutoSize = True
        Me._lbletiqueta_11.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_11, "Default")
        Me._lbletiqueta_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_11.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_11.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_11.Location = New System.Drawing.Point(10, 125)
        Me._lbletiqueta_11.Name = "_lbletiqueta_11"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_11, "9913")
        Me._lbletiqueta_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_11.Size = New System.Drawing.Size(70, 13)
        Me._lbletiqueta_11.TabIndex = 30
        Me._lbletiqueta_11.Text = "*Concepto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_11, "")
        '
        '_lblValor_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblValor_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblValor_7, False)
        Me._lblValor_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblValor_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblValor_7, "Default")
        Me._lblValor_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblValor_7.Location = New System.Drawing.Point(147, 148)
        Me._lblValor_7.Name = "_lblValor_7"
        Me._lblValor_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblValor_7.Size = New System.Drawing.Size(222, 20)
        Me._lblValor_7.TabIndex = 29
        Me._lblValor_7.Tag = "2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblValor_7, "")
        '
        '_lbletiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_8, False)
        Me._lbletiqueta_8.AutoSize = True
        Me._lbletiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_8, "Default")
        Me._lbletiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_8.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_8.Location = New System.Drawing.Point(10, 148)
        Me._lbletiqueta_8.Name = "_lbletiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_8, "501061")
        Me._lbletiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_8.Size = New System.Drawing.Size(109, 13)
        Me._lbletiqueta_8.TabIndex = 28
        Me._lbletiqueta_8.Text = "*Cuenta Principal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_8, "")
        '
        '_lblValor_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblValor_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblValor_6, False)
        Me._lblValor_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblValor_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblValor_6, "Default")
        Me._lblValor_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblValor_6.Location = New System.Drawing.Point(147, 125)
        Me._lblValor_6.Name = "_lblValor_6"
        Me._lblValor_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblValor_6.Size = New System.Drawing.Size(472, 20)
        Me._lblValor_6.TabIndex = 27
        Me._lblValor_6.Tag = "2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblValor_6, "")
        '
        '_lbletiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_6, False)
        Me._lbletiqueta_6.AutoSize = True
        Me._lbletiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_6, "Default")
        Me._lbletiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_6.Location = New System.Drawing.Point(10, 41)
        Me._lbletiqueta_6.Name = "_lbletiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_6, "508700")
        Me._lbletiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_6.Size = New System.Drawing.Size(113, 13)
        Me._lbletiqueta_6.TabIndex = 26
        Me._lbletiqueta_6.Text = "*Registros Errores:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_6, "")
        '
        '_lbletiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_10, False)
        Me._lbletiqueta_10.AutoSize = True
        Me._lbletiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_10, "Default")
        Me._lbletiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_10.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_10.Location = New System.Drawing.Point(372, 42)
        Me._lbletiqueta_10.Name = "_lbletiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_10, "5196")
        Me._lbletiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_10.Size = New System.Drawing.Size(51, 13)
        Me._lbletiqueta_10.TabIndex = 25
        Me._lbletiqueta_10.Text = "*Monto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_10, "")
        '
        '_lblValor_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblValor_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblValor_4, False)
        Me._lblValor_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblValor_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblValor_4, "Default")
        Me._lblValor_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblValor_4.Location = New System.Drawing.Point(150, 41)
        Me._lblValor_4.Name = "_lblValor_4"
        Me._lblValor_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblValor_4.Size = New System.Drawing.Size(209, 20)
        Me._lblValor_4.TabIndex = 24
        Me._lblValor_4.Tag = "2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblValor_4, "")
        '
        '_lblValor_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblValor_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblValor_5, False)
        Me._lblValor_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblValor_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblValor_5, "Default")
        Me._lblValor_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblValor_5.Location = New System.Drawing.Point(426, 42)
        Me._lblValor_5.Name = "_lblValor_5"
        Me._lblValor_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblValor_5.Size = New System.Drawing.Size(177, 20)
        Me._lblValor_5.TabIndex = 23
        Me._lblValor_5.Tag = "2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblValor_5, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(212, 10)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(30, 20)
        Me._lblDescripcion_1.TabIndex = 21
        Me._lblDescripcion_1.UseMnemonic = False
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
        Me._lblDescripcion_2.Location = New System.Drawing.Point(244, 10)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(125, 20)
        Me._lblDescripcion_2.TabIndex = 20
        Me._lblDescripcion_2.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(147, 33)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(472, 20)
        Me._lblDescripcion_3.TabIndex = 19
        Me._lblDescripcion_3.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblValor_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblValor_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblValor_3, False)
        Me._lblValor_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblValor_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblValor_3, "Default")
        Me._lblValor_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblValor_3.Location = New System.Drawing.Point(426, 19)
        Me._lblValor_3.Name = "_lblValor_3"
        Me._lblValor_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblValor_3.Size = New System.Drawing.Size(177, 20)
        Me._lblValor_3.TabIndex = 18
        Me._lblValor_3.Tag = "2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblValor_3, "")
        '
        '_lblValor_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblValor_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblValor_2, False)
        Me._lblValor_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblValor_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblValor_2, "Default")
        Me._lblValor_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblValor_2.Location = New System.Drawing.Point(150, 19)
        Me._lblValor_2.Name = "_lblValor_2"
        Me._lblValor_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblValor_2.Size = New System.Drawing.Size(209, 20)
        Me._lblValor_2.TabIndex = 17
        Me._lblValor_2.Tag = "2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblValor_2, "")
        '
        '_lblValor_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblValor_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblValor_1, False)
        Me._lblValor_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblValor_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblValor_1, "Default")
        Me._lblValor_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblValor_1.Location = New System.Drawing.Point(147, 102)
        Me._lblValor_1.Name = "_lblValor_1"
        Me._lblValor_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblValor_1.Size = New System.Drawing.Size(222, 20)
        Me._lblValor_1.TabIndex = 16
        Me._lblValor_1.Tag = "2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblValor_1, "")
        '
        '_lblValor_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblValor_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblValor_0, False)
        Me._lblValor_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblValor_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblValor_0, "Default")
        Me._lblValor_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblValor_0.Location = New System.Drawing.Point(147, 79)
        Me._lblValor_0.Name = "_lblValor_0"
        Me._lblValor_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblValor_0.Size = New System.Drawing.Size(222, 20)
        Me._lblValor_0.TabIndex = 15
        Me._lblValor_0.Tag = "2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblValor_0, "")
        '
        '_lbletiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_9, False)
        Me._lbletiqueta_9.AutoSize = True
        Me._lbletiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_9, "Default")
        Me._lbletiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_9.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_9.Location = New System.Drawing.Point(372, 19)
        Me._lbletiqueta_9.Name = "_lbletiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_9, "5196")
        Me._lbletiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_9.Size = New System.Drawing.Size(51, 13)
        Me._lbletiqueta_9.TabIndex = 14
        Me._lbletiqueta_9.Text = "*Monto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_9, "")
        '
        '_lbletiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_7, False)
        Me._lbletiqueta_7.AutoSize = True
        Me._lbletiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_7, "Default")
        Me._lbletiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_7.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_7.Location = New System.Drawing.Point(10, 19)
        Me._lbletiqueta_7.Name = "_lbletiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_7, "508702")
        Me._lbletiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_7.Size = New System.Drawing.Size(139, 13)
        Me._lbletiqueta_7.TabIndex = 13
        Me._lbletiqueta_7.Text = "*Registros Procesados:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_7, "")
        '
        '_lbletiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_5, False)
        Me._lbletiqueta_5.AutoSize = True
        Me._lbletiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_5, "Default")
        Me._lbletiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_5.Location = New System.Drawing.Point(10, 102)
        Me._lbletiqueta_5.Name = "_lbletiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_5, "508738")
        Me._lbletiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_5.Size = New System.Drawing.Size(102, 13)
        Me._lbletiqueta_5.TabIndex = 12
        Me._lbletiqueta_5.Text = "*Total Registros:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_5, "")
        '
        '_lbletiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_3, False)
        Me._lbletiqueta_3.AutoSize = True
        Me._lbletiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_3, "Default")
        Me._lbletiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_3.Location = New System.Drawing.Point(10, 79)
        Me._lbletiqueta_3.Name = "_lbletiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_3, "508635")
        Me._lbletiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_3.Size = New System.Drawing.Size(129, 13)
        Me._lbletiqueta_3.TabIndex = 11
        Me._lbletiqueta_3.Text = "*Monto Inicial Transf:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_3, "")
        '
        '_lbletiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_2, False)
        Me._lbletiqueta_2.AutoSize = True
        Me._lbletiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_2, "Default")
        Me._lbletiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_2.Location = New System.Drawing.Point(10, 56)
        Me._lbletiqueta_2.Name = "_lbletiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_2, "508654")
        Me._lbletiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_2.Size = New System.Drawing.Size(106, 13)
        Me._lbletiqueta_2.TabIndex = 10
        Me._lbletiqueta_2.Text = "*Nombre Archivo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_2, "")
        '
        '_lbletiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_0, False)
        Me._lbletiqueta_0.AutoSize = True
        Me._lbletiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_0, "Default")
        Me._lbletiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_0.Location = New System.Drawing.Point(10, 10)
        Me._lbletiqueta_0.Name = "_lbletiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_0, "500163")
        Me._lbletiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_0.Size = New System.Drawing.Size(55, 13)
        Me._lbletiqueta_0.TabIndex = 9
        Me._lbletiqueta_0.Text = "*Cliente:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_0, "")
        '
        '_lbletiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_1, False)
        Me._lbletiqueta_1.AutoSize = True
        Me._lbletiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_1, "Default")
        Me._lbletiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbletiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_1.Location = New System.Drawing.Point(403, 10)
        Me._lbletiqueta_1.Name = "_lbletiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_1, "500348")
        Me._lbletiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_1.Size = New System.Drawing.Size(51, 13)
        Me._lbletiqueta_1.TabIndex = 0
        Me._lbletiqueta_1.Text = "*Fecha:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._lblDescripcion_2)
        Me.PFormas.Controls.Add(Me.MskFecha)
        Me.PFormas.Controls.Add(Me._lbletiqueta_1)
        Me.PFormas.Controls.Add(Me._txtCampo_1)
        Me.PFormas.Controls.Add(Me._lbletiqueta_0)
        Me.PFormas.Controls.Add(Me.txtCliente)
        Me.PFormas.Controls.Add(Me._lbletiqueta_2)
        Me.PFormas.Controls.Add(Me._lbletiqueta_3)
        Me.PFormas.Controls.Add(Me._lbletiqueta_5)
        Me.PFormas.Controls.Add(Me._lblValor_0)
        Me.PFormas.Controls.Add(Me._lblValor_8)
        Me.PFormas.Controls.Add(Me._lblValor_1)
        Me.PFormas.Controls.Add(Me._lbletiqueta_12)
        Me.PFormas.Controls.Add(Me._lbletiqueta_11)
        Me.PFormas.Controls.Add(Me._lblValor_7)
        Me.PFormas.Controls.Add(Me._lblDescripcion_3)
        Me.PFormas.Controls.Add(Me._lbletiqueta_8)
        Me.PFormas.Controls.Add(Me._lblDescripcion_1)
        Me.PFormas.Controls.Add(Me._lblValor_6)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(12, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(635, 442)
        Me.PFormas.TabIndex = 33
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdDetalle)
        Me.GroupBox1.Controls.Add(Me._lblValor_2)
        Me.GroupBox1.Controls.Add(Me._lblValor_4)
        Me.GroupBox1.Controls.Add(Me._lbletiqueta_10)
        Me.GroupBox1.Controls.Add(Me._lblValor_5)
        Me.GroupBox1.Controls.Add(Me._lbletiqueta_6)
        Me.GroupBox1.Controls.Add(Me._lblValor_3)
        Me.GroupBox1.Controls.Add(Me._lbletiqueta_9)
        Me.GroupBox1.Controls.Add(Me._lbletiqueta_7)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 196)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "502288")
        Me.GroupBox1.Size = New System.Drawing.Size(609, 236)
        Me.GroupBox1.TabIndex = 33
        Me.GroupBox1.Text = "*Detalle:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBExcel, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(658, 25)
        Me.TSBotones.TabIndex = 5
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
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
        'TSBExcel
        '
        Me.TSBExcel.ForeColor = System.Drawing.Color.Navy
        Me.TSBExcel.Image = CType(resources.GetObject("TSBExcel.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBExcel, "2500")
        Me.TSBExcel.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBExcel.Name = "TSBExcel"
        Me.COBISResourceProvider.SetResourceID(Me.TSBExcel, "501619")
        Me.TSBExcel.Size = New System.Drawing.Size(58, 22)
        Me.TSBExcel.Text = "*&Excel"
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
        'FArchTransfClass
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
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(4, 30)
        Me.Name = "FArchTransfClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(658, 493)
        Me.Text = "Consulta Archivo Transferencias Masivas"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdDetalle, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(1) = _txtCampo_1
    End Sub
    Sub Initializelbletiqueta()
        Me.lbletiqueta(12) = _lbletiqueta_12
        Me.lbletiqueta(11) = _lbletiqueta_11
        Me.lbletiqueta(8) = _lbletiqueta_8
        Me.lbletiqueta(6) = _lbletiqueta_6
        Me.lbletiqueta(10) = _lbletiqueta_10
        Me.lbletiqueta(9) = _lbletiqueta_9
        Me.lbletiqueta(7) = _lbletiqueta_7
        Me.lbletiqueta(5) = _lbletiqueta_5
        Me.lbletiqueta(3) = _lbletiqueta_3
        Me.lbletiqueta(2) = _lbletiqueta_2
        Me.lbletiqueta(0) = _lbletiqueta_0
        Me.lbletiqueta(1) = _lbletiqueta_1
    End Sub
    Sub InitializelblValor()
        Me.lblValor(8) = _lblValor_8
        Me.lblValor(7) = _lblValor_7
        Me.lblValor(6) = _lblValor_6
        Me.lblValor(4) = _lblValor_4
        Me.lblValor(5) = _lblValor_5
        Me.lblValor(3) = _lblValor_3
        Me.lblValor(2) = _lblValor_2
        Me.lblValor(1) = _lblValor_1
        Me.lblValor(0) = _lblValor_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(3) = _lblDescripcion_3
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(2) = _cmdBoton_2
    End Sub

    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBExcel As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region
End Class


