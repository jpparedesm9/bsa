Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FDevRecCBClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializemskFecha()
		InitializelblEtiqueta()
		InitializecmdSalir()
		InitializecmdLimpiar()
		InitializecmdExcel()
		InitializeLine1()
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
    Public WithEvents txtDiasDev As System.Windows.Forms.TextBox
    Public WithEvents txtCB As System.Windows.Forms.TextBox
    Private WithEvents _mskFecha_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _mskFecha_0 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents cmdBuscar As System.Windows.Forms.Button
    Public WithEvents cmdSiguientes As System.Windows.Forms.Button
    Private WithEvents _cmdSalir_3 As System.Windows.Forms.Button
    Private WithEvents _cmdExcel_1 As System.Windows.Forms.Button
    Private WithEvents _cmdLimpiar_2 As System.Windows.Forms.Button
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents lblCuentaCB As System.Windows.Forms.Label
    Public WithEvents lblCupo As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
	Public WithEvents lblCB As System.Windows.Forms.Label
	Public Line1(3) As System.Windows.Forms.Label
	Public cmdExcel(1) As System.Windows.Forms.Button
	Public cmdLimpiar(2) As System.Windows.Forms.Button
	Public cmdSalir(3) As System.Windows.Forms.Button
	Public lblEtiqueta(4) As System.Windows.Forms.Label
	Public mskFecha(1) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FDevRecCBClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.txtDiasDev = New System.Windows.Forms.TextBox()
        Me.txtCB = New System.Windows.Forms.TextBox()
        Me._mskFecha_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._mskFecha_0 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.cmdBuscar = New System.Windows.Forms.Button()
        Me.cmdSiguientes = New System.Windows.Forms.Button()
        Me._cmdSalir_3 = New System.Windows.Forms.Button()
        Me._cmdExcel_1 = New System.Windows.Forms.Button()
        Me._cmdLimpiar_2 = New System.Windows.Forms.Button()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.lblCuentaCB = New System.Windows.Forms.Label()
        Me.lblCupo = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.lblCB = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBExcel = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
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
        'txtDiasDev
        '
        Me.txtDiasDev.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtDiasDev, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtDiasDev, False)
        Me.txtDiasDev.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtDiasDev, "Default")
        Me.txtDiasDev.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtDiasDev.Location = New System.Drawing.Point(524, 56)
        Me.txtDiasDev.MaxLength = 2
        Me.txtDiasDev.Name = "txtDiasDev"
        Me.txtDiasDev.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtDiasDev.Size = New System.Drawing.Size(39, 20)
        Me.txtDiasDev.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtDiasDev, "")
        '
        'txtCB
        '
        Me.txtCB.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCB, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCB, False)
        Me.txtCB.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCB, "Default")
        Me.txtCB.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCB.Location = New System.Drawing.Point(108, 10)
        Me.txtCB.MaxLength = 5
        Me.txtCB.Name = "txtCB"
        Me.txtCB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCB.Size = New System.Drawing.Size(83, 20)
        Me.txtCB.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCB, "")
        '
        '_mskFecha_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskFecha_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskFecha_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskFecha_1, "Default")
        Me._mskFecha_1.Length = CType(64, Short)
        Me._mskFecha_1.Location = New System.Drawing.Point(309, 56)
        Me._mskFecha_1.Mask = "##/##/####"
        Me._mskFecha_1.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me._mskFecha_1.MaxReal = 3.402823E+38!
        Me._mskFecha_1.MinReal = -3.402823E+38!
        Me._mskFecha_1.Name = "_mskFecha_1"
        Me._mskFecha_1.Size = New System.Drawing.Size(83, 20)
        Me._mskFecha_1.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskFecha_1, "")
        '
        '_mskFecha_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskFecha_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskFecha_0, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskFecha_0, "Default")
        Me._mskFecha_0.Length = CType(64, Short)
        Me._mskFecha_0.Location = New System.Drawing.Point(108, 56)
        Me._mskFecha_0.Mask = "##/##/####"
        Me._mskFecha_0.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me._mskFecha_0.MaxReal = 3.402823E+38!
        Me._mskFecha_0.MinReal = -3.402823E+38!
        Me._mskFecha_0.Name = "_mskFecha_0"
        Me._mskFecha_0.Size = New System.Drawing.Size(83, 20)
        Me._mskFecha_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskFecha_0, "")
        '
        'cmdBuscar
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdBuscar, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdBuscar, False)
        Me.cmdBuscar.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdBuscar, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdBuscar, True)
        Me.cmdBuscar.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdBuscar, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdBuscar, Nothing)
        Me.cmdBuscar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdBuscar.Location = New System.Drawing.Point(-606, 33)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdBuscar, System.Drawing.Color.Silver)
        Me.cmdBuscar.Name = "cmdBuscar"
        Me.cmdBuscar.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdBuscar.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdBuscar, 1)
        Me.cmdBuscar.TabIndex = 5
        Me.cmdBuscar.Text = "*&Buscar"
        Me.cmdBuscar.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdBuscar.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdBuscar, "")
        '
        'cmdSiguientes
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdSiguientes, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdSiguientes, False)
        Me.cmdSiguientes.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdSiguientes, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdSiguientes, True)
        Me.cmdSiguientes.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdSiguientes, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdSiguientes, Nothing)
        Me.cmdSiguientes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSiguientes.Location = New System.Drawing.Point(-606, 84)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSiguientes, System.Drawing.Color.Silver)
        Me.cmdSiguientes.Name = "cmdSiguientes"
        Me.cmdSiguientes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSiguientes.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdSiguientes, 1)
        Me.cmdSiguientes.TabIndex = 6
        Me.cmdSiguientes.Text = "*&Siguiente"
        Me.cmdSiguientes.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSiguientes.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSiguientes, "")
        '
        '_cmdSalir_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdSalir_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdSalir_3, False)
        Me._cmdSalir_3.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdSalir_3, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdSalir_3, True)
        Me._cmdSalir_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdSalir_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdSalir_3, Nothing)
        Me._cmdSalir_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSalir_3.Location = New System.Drawing.Point(-606, 239)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSalir_3, System.Drawing.Color.Silver)
        Me._cmdSalir_3.Name = "_cmdSalir_3"
        Me._cmdSalir_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSalir_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdSalir_3, 1)
        Me._cmdSalir_3.TabIndex = 9
        Me._cmdSalir_3.Text = "*&Salir"
        Me._cmdSalir_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdSalir_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdSalir_3, "")
        '
        '_cmdExcel_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdExcel_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdExcel_1, False)
        Me._cmdExcel_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdExcel_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdExcel_1, True)
        Me._cmdExcel_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdExcel_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdExcel_1, Nothing)
        Me._cmdExcel_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdExcel_1.Location = New System.Drawing.Point(-606, 136)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdExcel_1, System.Drawing.Color.Silver)
        Me._cmdExcel_1.Name = "_cmdExcel_1"
        Me._cmdExcel_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdExcel_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdExcel_1, 1)
        Me._cmdExcel_1.TabIndex = 7
        Me._cmdExcel_1.Text = "*&Excel"
        Me._cmdExcel_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdExcel_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdExcel_1, "")
        '
        '_cmdLimpiar_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdLimpiar_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdLimpiar_2, False)
        Me._cmdLimpiar_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdLimpiar_2, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdLimpiar_2, True)
        Me._cmdLimpiar_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdLimpiar_2, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdLimpiar_2, Nothing)
        Me._cmdLimpiar_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdLimpiar_2.Location = New System.Drawing.Point(-606, 187)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdLimpiar_2, System.Drawing.Color.Silver)
        Me._cmdLimpiar_2.Name = "_cmdLimpiar_2"
        Me._cmdLimpiar_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdLimpiar_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdLimpiar_2, 1)
        Me._cmdLimpiar_2.TabIndex = 8
        Me._cmdLimpiar_2.Text = "*&Limpiar"
        Me._cmdLimpiar_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdLimpiar_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdLimpiar_2, "")
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
        Me.grdRegistros.Location = New System.Drawing.Point(9, 13)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(535, 151)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 5
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        'lblCuentaCB
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCuentaCB, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCuentaCB, False)
        Me.lblCuentaCB.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblCuentaCB.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblCuentaCB, "Default")
        Me.lblCuentaCB.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCuentaCB.Location = New System.Drawing.Point(524, 33)
        Me.lblCuentaCB.Name = "lblCuentaCB"
        Me.lblCuentaCB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCuentaCB.Size = New System.Drawing.Size(39, 20)
        Me.lblCuentaCB.TabIndex = 17
        Me.lblCuentaCB.UseMnemonic = False
        Me.lblCuentaCB.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCuentaCB, "")
        '
        'lblCupo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCupo, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCupo, False)
        Me.lblCupo.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblCupo.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblCupo, "Default")
        Me.lblCupo.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCupo.Location = New System.Drawing.Point(108, 33)
        Me.lblCupo.Name = "lblCupo"
        Me.lblCupo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCupo.Size = New System.Drawing.Size(83, 20)
        Me.lblCupo.TabIndex = 16
        Me.lblCupo.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCupo, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(228, 56)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "501499")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(77, 20)
        Me._lblEtiqueta_4.TabIndex = 13
        Me._lblEtiqueta_4.Text = "*Fecha Hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "508491")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(90, 20)
        Me._lblEtiqueta_3.TabIndex = 12
        Me._lblEtiqueta_3.Text = "*Cupo Asignado:"
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
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(420, 56)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "508529")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(100, 20)
        Me._lblEtiqueta_2.TabIndex = 11
        Me._lblEtiqueta_2.Text = "*Días Devolución:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "508568")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(80, 20)
        Me._lblEtiqueta_1.TabIndex = 10
        Me._lblEtiqueta_1.Text = "*Fecha Desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "508696")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(108, 20)
        Me._lblEtiqueta_0.TabIndex = 0
        Me._lblEtiqueta_0.Text = "*Red Posicionada:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'lblCB
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCB, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCB, False)
        Me.lblCB.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblCB.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblCB, "Default")
        Me.lblCB.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCB.Location = New System.Drawing.Point(194, 10)
        Me.lblCB.Name = "lblCB"
        Me.lblCB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCB.Size = New System.Drawing.Size(369, 20)
        Me.lblCB.TabIndex = 15
        Me.lblCB.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCB, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me.txtDiasDev)
        Me.PFormas.Controls.Add(Me.lblCB)
        Me.PFormas.Controls.Add(Me.txtCB)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me._mskFecha_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_2)
        Me.PFormas.Controls.Add(Me._mskFecha_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_3)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_4)
        Me.PFormas.Controls.Add(Me.lblCupo)
        Me.PFormas.Controls.Add(Me.lblCuentaCB)
        Me.PFormas.Controls.Add(Me._cmdExcel_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(571, 271)
        Me.PFormas.TabIndex = 18
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 84)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(553, 172)
        Me.GroupBox1.TabIndex = 18
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBExcel, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(586, 25)
        Me.TSBotones.TabIndex = 19
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2001")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "500006")
        Me.TSBSiguiente.Size = New System.Drawing.Size(81, 22)
        Me.TSBSiguiente.Text = "*Siguien&te"
        '
        'TSBExcel
        '
        Me.TSBExcel.ForeColor = System.Drawing.SystemColors.WindowText
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
        Me.TSBLimpiar.ForeColor = System.Drawing.SystemColors.WindowText
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
        Me.TSBSalir.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FDevRecCBClass
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
        Me.Location = New System.Drawing.Point(4, 30)
        Me.Name = "FDevRecCBClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(586, 317)
        Me.Text = "Devolución Valores Recaudado C.B."
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializemskFecha()
        Me.mskFecha(1) = _mskFecha_1
        Me.mskFecha(0) = _mskFecha_0
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializecmdSalir()
        Me.cmdSalir(3) = _cmdSalir_3
    End Sub
    Sub InitializecmdLimpiar()
        Me.cmdLimpiar(2) = _cmdLimpiar_2
    End Sub
    Sub InitializecmdExcel()
        Me.cmdExcel(1) = _cmdExcel_1
    End Sub
    Sub InitializeLine1()
        'Me.Line1(3) = _Line1_3
        'Me.Line1(1) = _Line1_1
    End Sub
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBExcel As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


