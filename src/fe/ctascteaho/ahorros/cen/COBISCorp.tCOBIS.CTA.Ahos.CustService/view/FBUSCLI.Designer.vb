Imports COBISCorp.tCOBIS.TADMIN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FBuscarClienteClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializeoptCriterio()
		InitializeoptCliente()
		InitializelblEtiqueta()
		InitializecmdBuscar()
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
	Public WithEvents OptionAmbos As System.Windows.Forms.RadioButton
	Public WithEvents OptionProspecto As System.Windows.Forms.RadioButton
	Public WithEvents OptionCliente As System.Windows.Forms.RadioButton
	Public WithEvents chkClientes As System.Windows.Forms.CheckBox
	Public WithEvents chkProspecto As System.Windows.Forms.CheckBox
	Public WithEvents Frame3D1 As Infragistics.Win.Misc.UltraGroupBox
	Public WithEvents grdResultados As COBISCorp.Framework.UI.Components.COBISGrid
	Public WithEvents txtValor As System.Windows.Forms.TextBox
	Private WithEvents _lblEtiqueta_0 As COBISCorp.Framework.UI.Components.COBISPanel
	Public WithEvents cmdSalir As System.Windows.Forms.Button
	Public WithEvents cmdEscoger As System.Windows.Forms.Button
	Private WithEvents _cmdBuscar_1 As System.Windows.Forms.Button
	Private WithEvents _cmdBuscar_0 As System.Windows.Forms.Button
	Public WithEvents txtAlianza As System.Windows.Forms.TextBox
	Private WithEvents _lblEtiqueta_1 As COBISCorp.Framework.UI.Components.COBISPanel
	Public WithEvents lblAlianza As COBISCorp.Framework.UI.Components.COBISPanel
	Public WithEvents fraAlianza As Infragistics.Win.Misc.UltraGroupBox
	Private WithEvents _optCriterio_3 As System.Windows.Forms.RadioButton
	Private WithEvents _optCriterio_1 As System.Windows.Forms.RadioButton
	Private WithEvents _optCriterio_0 As System.Windows.Forms.RadioButton
	Private WithEvents _optCriterio_2 As System.Windows.Forms.RadioButton
	Public WithEvents fraCriterio As Infragistics.Win.Misc.UltraGroupBox
	Private WithEvents _lblEtiqueta_2 As COBISCorp.Framework.UI.Components.COBISPanel
	Public WithEvents txtOficinaOpt As System.Windows.Forms.TextBox
	Private WithEvents _optCliente_0 As System.Windows.Forms.RadioButton
	Private WithEvents _optCliente_1 As System.Windows.Forms.RadioButton
	Public WithEvents FraCliente As Infragistics.Win.Misc.UltraGroupBox
	Public WithEvents lblDesOficina As System.Windows.Forms.Label
	Public WithEvents il_titulo02 As System.Windows.Forms.Label
	Public cmdBuscar(1) As System.Windows.Forms.Button
	Public lblEtiqueta(2) As COBISCorp.Framework.UI.Components.COBISPanel
	Public optCliente(1) As System.Windows.Forms.RadioButton
	Public optCriterio(3) As System.Windows.Forms.RadioButton
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FBuscarClienteClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.Frame3D1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.OptionAmbos = New System.Windows.Forms.RadioButton()
        Me.OptionProspecto = New System.Windows.Forms.RadioButton()
        Me.OptionCliente = New System.Windows.Forms.RadioButton()
        Me.chkClientes = New System.Windows.Forms.CheckBox()
        Me.chkProspecto = New System.Windows.Forms.CheckBox()
        Me.grdResultados = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.txtValor = New System.Windows.Forms.TextBox()
        Me._lblEtiqueta_0 = New COBISCorp.Framework.UI.Components.COBISPanel()
        Me.cmdSalir = New System.Windows.Forms.Button()
        Me.cmdEscoger = New System.Windows.Forms.Button()
        Me._cmdBuscar_1 = New System.Windows.Forms.Button()
        Me._cmdBuscar_0 = New System.Windows.Forms.Button()
        Me.fraAlianza = New Infragistics.Win.Misc.UltraGroupBox()
        Me.txtAlianza = New System.Windows.Forms.TextBox()
        Me._lblEtiqueta_1 = New COBISCorp.Framework.UI.Components.COBISPanel()
        Me.lblAlianza = New COBISCorp.Framework.UI.Components.COBISPanel()
        Me.fraCriterio = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optCriterio_3 = New System.Windows.Forms.RadioButton()
        Me._optCriterio_1 = New System.Windows.Forms.RadioButton()
        Me._optCriterio_0 = New System.Windows.Forms.RadioButton()
        Me._optCriterio_2 = New System.Windows.Forms.RadioButton()
        Me._lblEtiqueta_2 = New COBISCorp.Framework.UI.Components.COBISPanel()
        Me.txtOficinaOpt = New System.Windows.Forms.TextBox()
        Me.FraCliente = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optCliente_0 = New System.Windows.Forms.RadioButton()
        Me._optCliente_1 = New System.Windows.Forms.RadioButton()
        Me.lblDesOficina = New System.Windows.Forms.Label()
        Me.il_titulo02 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.Frame3D1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame3D1.SuspendLayout()
        CType(Me.grdResultados, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.fraAlianza, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraAlianza.SuspendLayout()
        CType(Me.fraCriterio, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraCriterio.SuspendLayout()
        CType(Me.FraCliente, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FraCliente.SuspendLayout()
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
        'Frame3D1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame3D1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame3D1, False)
        Me.Frame3D1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame3D1.Controls.Add(Me.OptionAmbos)
        Me.Frame3D1.Controls.Add(Me.OptionProspecto)
        Me.Frame3D1.Controls.Add(Me.OptionCliente)
        Me.Frame3D1.Controls.Add(Me.chkClientes)
        Me.Frame3D1.Controls.Add(Me.chkProspecto)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame3D1, "Default")
        Me.Frame3D1.ForeColor = System.Drawing.Color.Navy
        Me.Frame3D1.Location = New System.Drawing.Point(235, 10)
        Me.Frame3D1.Name = "Frame3D1"
        Me.COBISResourceProvider.SetResourceID(Me.Frame3D1, "500011")
        Me.Frame3D1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame3D1.Size = New System.Drawing.Size(356, 35)
        Me.Frame3D1.TabIndex = 20
        Me.Frame3D1.Text = "*Buscar"
        Me.Frame3D1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame3D1, "")
        '
        'OptionAmbos
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.OptionAmbos, False)
        Me.COBISViewResizer.SetAutoResize(Me.OptionAmbos, False)
        Me.OptionAmbos.BackColor = System.Drawing.Color.Transparent
        Me.OptionAmbos.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me.OptionAmbos, "Default")
        Me.OptionAmbos.Cursor = System.Windows.Forms.Cursors.Default
        Me.OptionAmbos.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.OptionAmbos.Location = New System.Drawing.Point(192, 15)
        Me.OptionAmbos.Name = "OptionAmbos"
        Me.COBISResourceProvider.SetResourceID(Me.OptionAmbos, "501613")
        Me.OptionAmbos.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.OptionAmbos.Size = New System.Drawing.Size(65, 15)
        Me.OptionAmbos.TabIndex = 2
        Me.OptionAmbos.TabStop = True
        Me.OptionAmbos.Text = "*Todos"
        Me.OptionAmbos.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.OptionAmbos, "")
        '
        'OptionProspecto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.OptionProspecto, False)
        Me.COBISViewResizer.SetAutoResize(Me.OptionProspecto, False)
        Me.OptionProspecto.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.OptionProspecto, "Default")
        Me.OptionProspecto.Cursor = System.Windows.Forms.Cursors.Default
        Me.OptionProspecto.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.OptionProspecto.Location = New System.Drawing.Point(97, 15)
        Me.OptionProspecto.Name = "OptionProspecto"
        Me.COBISResourceProvider.SetResourceID(Me.OptionProspecto, "500139")
        Me.OptionProspecto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.OptionProspecto.Size = New System.Drawing.Size(93, 15)
        Me.OptionProspecto.TabIndex = 1
        Me.OptionProspecto.TabStop = True
        Me.OptionProspecto.Text = "*Prospectos"
        Me.OptionProspecto.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.OptionProspecto, "")
        '
        'OptionCliente
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.OptionCliente, False)
        Me.COBISViewResizer.SetAutoResize(Me.OptionCliente, False)
        Me.OptionCliente.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.OptionCliente, "Default")
        Me.OptionCliente.Cursor = System.Windows.Forms.Cursors.Default
        Me.OptionCliente.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.OptionCliente.Location = New System.Drawing.Point(16, 15)
        Me.OptionCliente.Name = "OptionCliente"
        Me.COBISResourceProvider.SetResourceID(Me.OptionCliente, "500140")
        Me.OptionCliente.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.OptionCliente.Size = New System.Drawing.Size(75, 15)
        Me.OptionCliente.TabIndex = 0
        Me.OptionCliente.TabStop = True
        Me.OptionCliente.Text = "*Clientes"
        Me.OptionCliente.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.OptionCliente, "")
        '
        'chkClientes
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkClientes, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkClientes, False)
        Me.chkClientes.BackColor = System.Drawing.Color.Transparent
        Me.chkClientes.Checked = True
        Me.chkClientes.CheckState = System.Windows.Forms.CheckState.Checked
        Me.COBISStyleProvider.SetControlStyle(Me.chkClientes, "Default")
        Me.chkClientes.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkClientes.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.chkClientes.Location = New System.Drawing.Point(116, 35)
        Me.chkClientes.Name = "chkClientes"
        Me.chkClientes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkClientes.Size = New System.Drawing.Size(67, 14)
        Me.chkClientes.TabIndex = 22
        Me.chkClientes.Text = "Clientes"
        Me.chkClientes.UseVisualStyleBackColor = True
        Me.chkClientes.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkClientes, "")
        '
        'chkProspecto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkProspecto, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkProspecto, False)
        Me.chkProspecto.BackColor = System.Drawing.Color.Transparent
        Me.chkProspecto.Checked = True
        Me.chkProspecto.CheckState = System.Windows.Forms.CheckState.Checked
        Me.COBISStyleProvider.SetControlStyle(Me.chkProspecto, "Default")
        Me.chkProspecto.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkProspecto.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.chkProspecto.Location = New System.Drawing.Point(23, 35)
        Me.chkProspecto.Name = "chkProspecto"
        Me.chkProspecto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkProspecto.Size = New System.Drawing.Size(81, 14)
        Me.chkProspecto.TabIndex = 21
        Me.chkProspecto.Text = "Prospectos"
        Me.chkProspecto.UseVisualStyleBackColor = True
        Me.chkProspecto.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkProspecto, "")
        '
        'grdResultados
        '
        Me.grdResultados._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdResultados, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdResultados, False)
        Me.grdResultados.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdResultados.Clip = ""
        Me.grdResultados.Col = CType(1, Short)
        Me.grdResultados.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdResultados.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdResultados.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdResultados, "Default")
        Me.grdResultados.CtlText = ""
        Me.grdResultados.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdResultados, True)
        Me.grdResultados.FixedCols = CType(1, Short)
        Me.grdResultados.FixedRows = CType(1, Short)
        Me.grdResultados.ForeColor = System.Drawing.Color.Black
        Me.grdResultados.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdResultados.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdResultados.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdResultados.HighLight = True
        Me.grdResultados.Location = New System.Drawing.Point(3, 0)
        Me.grdResultados.Name = "grdResultados"
        Me.grdResultados.Picture = Nothing
        Me.grdResultados.Row = CType(1, Short)
        Me.grdResultados.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdResultados.Size = New System.Drawing.Size(574, 228)
        Me.grdResultados.Sort = CType(2, Short)
        Me.grdResultados.TabIndex = 11
        Me.grdResultados.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdResultados, "")
        '
        'txtValor
        '
        Me.txtValor.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtValor, False)
        Me.txtValor.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtValor, "Default")
        Me.txtValor.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtValor.Location = New System.Drawing.Point(138, 128)
        Me.txtValor.MaxLength = 0
        Me.txtValor.Name = "txtValor"
        Me.txtValor.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtValor.Size = New System.Drawing.Size(449, 20)
        Me.txtValor.TabIndex = 6
        Me.txtValor.Text = "%"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtValor, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.FloodColor = System.Drawing.Color.Transparent
        Me._lblEtiqueta_0.FloodPercent = CType(0, Short)
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 128)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "2510")
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(123, 20)
        Me._lblEtiqueta_0.TabIndex = 16
        Me._lblEtiqueta_0.Text = "*Valor de Búsqueda:"
        Me._lblEtiqueta_0.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
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
        Me.cmdSalir.Image = CType(resources.GetObject("cmdSalir.Image"), System.Drawing.Image)
        Me.cmdSalir.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me.cmdSalir.Location = New System.Drawing.Point(-637, 381)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSalir, System.Drawing.Color.Silver)
        Me.cmdSalir.Name = "cmdSalir"
        Me.cmdSalir.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSalir.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdSalir, 1)
        Me.cmdSalir.TabIndex = 10
        Me.cmdSalir.Text = "&Salir"
        Me.cmdSalir.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdSalir.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSalir.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSalir, "")
        '
        'cmdEscoger
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdEscoger, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdEscoger, False)
        Me.cmdEscoger.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdEscoger, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdEscoger, True)
        Me.cmdEscoger.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdEscoger, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdEscoger, Nothing)
        Me.cmdEscoger.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdEscoger.Image = CType(resources.GetObject("cmdEscoger.Image"), System.Drawing.Image)
        Me.cmdEscoger.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me.cmdEscoger.Location = New System.Drawing.Point(-637, 324)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdEscoger, System.Drawing.Color.Silver)
        Me.cmdEscoger.Name = "cmdEscoger"
        Me.cmdEscoger.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdEscoger.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdEscoger, 1)
        Me.cmdEscoger.TabIndex = 9
        Me.cmdEscoger.Text = "&Escoger"
        Me.cmdEscoger.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdEscoger.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdEscoger.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdEscoger, "")
        '
        '_cmdBuscar_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBuscar_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBuscar_1, False)
        Me._cmdBuscar_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBuscar_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBuscar_1, True)
        Me._cmdBuscar_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBuscar_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBuscar_1, Nothing)
        Me._cmdBuscar_1.Enabled = False
        Me._cmdBuscar_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBuscar_1.Image = CType(resources.GetObject("_cmdBuscar_1.Image"), System.Drawing.Image)
        Me._cmdBuscar_1.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBuscar_1.Location = New System.Drawing.Point(-637, 269)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBuscar_1, System.Drawing.Color.Silver)
        Me._cmdBuscar_1.Name = "_cmdBuscar_1"
        Me._cmdBuscar_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBuscar_1.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBuscar_1, 1)
        Me._cmdBuscar_1.TabIndex = 8
        Me._cmdBuscar_1.Text = "Si&guiente"
        Me._cmdBuscar_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBuscar_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBuscar_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBuscar_1, "")
        '
        '_cmdBuscar_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBuscar_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBuscar_0, False)
        Me._cmdBuscar_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBuscar_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBuscar_0, True)
        Me._cmdBuscar_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBuscar_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBuscar_0, Nothing)
        Me._cmdBuscar_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBuscar_0.Image = CType(resources.GetObject("_cmdBuscar_0.Image"), System.Drawing.Image)
        Me._cmdBuscar_0.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBuscar_0.Location = New System.Drawing.Point(-637, 210)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBuscar_0, System.Drawing.Color.Silver)
        Me._cmdBuscar_0.Name = "_cmdBuscar_0"
        Me._cmdBuscar_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBuscar_0.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBuscar_0, 1)
        Me._cmdBuscar_0.TabIndex = 7
        Me._cmdBuscar_0.Tag = "1182;1241;1318"
        Me._cmdBuscar_0.Text = "&Buscar"
        Me._cmdBuscar_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBuscar_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBuscar_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBuscar_0, "")
        '
        'fraAlianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraAlianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraAlianza, False)
        Me.fraAlianza.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraAlianza.Controls.Add(Me.txtAlianza)
        Me.fraAlianza.Controls.Add(Me._lblEtiqueta_1)
        Me.fraAlianza.Controls.Add(Me.lblAlianza)
        Me.COBISStyleProvider.SetControlStyle(Me.fraAlianza, "Default")
        Me.fraAlianza.ForeColor = System.Drawing.Color.Navy
        Me.fraAlianza.Location = New System.Drawing.Point(10, 44)
        Me.fraAlianza.Name = "fraAlianza"
        Me.fraAlianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraAlianza.Size = New System.Drawing.Size(580, 35)
        Me.fraAlianza.TabIndex = 14
        Me.fraAlianza.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraAlianza, "")
        '
        'txtAlianza
        '
        Me.txtAlianza.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtAlianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtAlianza, False)
        Me.txtAlianza.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtAlianza, "Default")
        Me.txtAlianza.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtAlianza.Location = New System.Drawing.Point(129, 11)
        Me.txtAlianza.MaxLength = 8
        Me.txtAlianza.Name = "txtAlianza"
        Me.txtAlianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtAlianza.Size = New System.Drawing.Size(56, 20)
        Me.txtAlianza.TabIndex = 27
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtAlianza, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.FloodColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._lblEtiqueta_1.FloodPercent = CType(0, Short)
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(8, 11)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "2508")
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(118, 20)
        Me._lblEtiqueta_1.TabIndex = 26
        Me._lblEtiqueta_1.Text = "*Alianza Comercial:"
        Me._lblEtiqueta_1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        'lblAlianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblAlianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblAlianza, False)
        Me.lblAlianza.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.lblAlianza, "Default")
        Me.lblAlianza.FloodColor = System.Drawing.Color.Empty
        Me.lblAlianza.FloodPercent = CType(0, Short)
        Me.lblAlianza.Location = New System.Drawing.Point(187, 11)
        Me.lblAlianza.Name = "lblAlianza"
        Me.lblAlianza.Size = New System.Drawing.Size(390, 20)
        Me.lblAlianza.TabIndex = 28
        Me.lblAlianza.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblAlianza, "")
        '
        'fraCriterio
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraCriterio, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraCriterio, False)
        Me.fraCriterio.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraCriterio.Controls.Add(Me._optCriterio_3)
        Me.fraCriterio.Controls.Add(Me._optCriterio_1)
        Me.fraCriterio.Controls.Add(Me._optCriterio_0)
        Me.fraCriterio.Controls.Add(Me._optCriterio_2)
        Me.COBISStyleProvider.SetControlStyle(Me.fraCriterio, "Default")
        Me.fraCriterio.ForeColor = System.Drawing.Color.Navy
        Me.fraCriterio.Location = New System.Drawing.Point(10, 80)
        Me.fraCriterio.Name = "fraCriterio"
        Me.COBISResourceProvider.SetResourceID(Me.fraCriterio, "5089")
        Me.fraCriterio.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraCriterio.Size = New System.Drawing.Size(581, 45)
        Me.fraCriterio.TabIndex = 13
        Me.fraCriterio.Text = "*Criterios de Búsqueda"
        Me.fraCriterio.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraCriterio, "")
        '
        '_optCriterio_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCriterio_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCriterio_3, False)
        Me._optCriterio_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optCriterio_3, "Default")
        Me._optCriterio_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_3.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optCriterio_3.Location = New System.Drawing.Point(24, 17)
        Me._optCriterio_3.Name = "_optCriterio_3"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_3, "500145")
        Me._optCriterio_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_3.Size = New System.Drawing.Size(87, 15)
        Me._optCriterio_3.TabIndex = 3
        Me._optCriterio_3.TabStop = True
        Me._optCriterio_3.Text = "*&Alfabético"
        Me._optCriterio_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCriterio_3, "")
        '
        '_optCriterio_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCriterio_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCriterio_1, False)
        Me._optCriterio_1.BackColor = System.Drawing.Color.Transparent
        Me._optCriterio_1.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optCriterio_1, "Default")
        Me._optCriterio_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_1.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optCriterio_1.Location = New System.Drawing.Point(182, 17)
        Me._optCriterio_1.Name = "_optCriterio_1"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_1, "2509")
        Me._optCriterio_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_1.Size = New System.Drawing.Size(167, 15)
        Me._optCriterio_1.TabIndex = 4
        Me._optCriterio_1.TabStop = True
        Me._optCriterio_1.Text = "*Número de &D.I."
        Me._optCriterio_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCriterio_1, "")
        '
        '_optCriterio_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCriterio_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCriterio_0, False)
        Me._optCriterio_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optCriterio_0, "Default")
        Me._optCriterio_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_0.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optCriterio_0.Location = New System.Drawing.Point(384, 17)
        Me._optCriterio_0.Name = "_optCriterio_0"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_0, "500148")
        Me._optCriterio_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_0.Size = New System.Drawing.Size(139, 15)
        Me._optCriterio_0.TabIndex = 5
        Me._optCriterio_0.Text = "*&Consecutivo Cliente"
        Me._optCriterio_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCriterio_0, "")
        '
        '_optCriterio_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCriterio_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCriterio_2, False)
        Me._optCriterio_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optCriterio_2, "Default")
        Me._optCriterio_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_2.Enabled = False
        Me._optCriterio_2.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optCriterio_2.Location = New System.Drawing.Point(536, 134)
        Me._optCriterio_2.Name = "_optCriterio_2"
        Me._optCriterio_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_2.Size = New System.Drawing.Size(37, 15)
        Me._optCriterio_2.TabIndex = 12
        Me._optCriterio_2.Text = "Pasapo&rte"
        Me._optCriterio_2.UseVisualStyleBackColor = True
        Me._optCriterio_2.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCriterio_2, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.FloodColor = System.Drawing.Color.Empty
        Me._lblEtiqueta_2.FloodPercent = CType(0, Short)
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(140, 141)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(47, 15)
        Me._lblEtiqueta_2.TabIndex = 17
        Me._lblEtiqueta_2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me._lblEtiqueta_2.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        'txtOficinaOpt
        '
        Me.txtOficinaOpt.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtOficinaOpt, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtOficinaOpt, False)
        Me.txtOficinaOpt.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtOficinaOpt, "Default")
        Me.txtOficinaOpt.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtOficinaOpt.Location = New System.Drawing.Point(184, 140)
        Me.txtOficinaOpt.MaxLength = 4
        Me.txtOficinaOpt.Name = "txtOficinaOpt"
        Me.txtOficinaOpt.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtOficinaOpt.Size = New System.Drawing.Size(50, 20)
        Me.txtOficinaOpt.TabIndex = 18
        Me.txtOficinaOpt.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtOficinaOpt, "")
        '
        'FraCliente
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FraCliente, False)
        Me.COBISViewResizer.SetAutoResize(Me.FraCliente, False)
        Me.FraCliente.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.FraCliente.Controls.Add(Me._optCliente_0)
        Me.FraCliente.Controls.Add(Me._optCliente_1)
        Me.COBISStyleProvider.SetControlStyle(Me.FraCliente, "Default")
        Me.FraCliente.ForeColor = System.Drawing.Color.Navy
        Me.FraCliente.Location = New System.Drawing.Point(10, 10)
        Me.FraCliente.Name = "FraCliente"
        Me.COBISResourceProvider.SetResourceID(Me.FraCliente, "500142")
        Me.FraCliente.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraCliente.Size = New System.Drawing.Size(221, 35)
        Me.FraCliente.TabIndex = 23
        Me.FraCliente.Text = "*Tipo de Cliente"
        Me.FraCliente.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FraCliente, "")
        '
        '_optCliente_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCliente_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCliente_0, False)
        Me._optCliente_0.BackColor = System.Drawing.Color.Transparent
        Me._optCliente_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optCliente_0, "Default")
        Me._optCliente_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCliente_0.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optCliente_0.Location = New System.Drawing.Point(128, 16)
        Me._optCliente_0.Name = "_optCliente_0"
        Me.COBISResourceProvider.SetResourceID(Me._optCliente_0, "500143")
        Me._optCliente_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCliente_0.Size = New System.Drawing.Size(89, 15)
        Me._optCliente_0.TabIndex = 24
        Me._optCliente_0.TabStop = True
        Me._optCliente_0.Text = "*P. &Natural"
        Me._optCliente_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCliente_0, "")
        '
        '_optCliente_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCliente_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCliente_1, False)
        Me._optCliente_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optCliente_1, "Default")
        Me._optCliente_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCliente_1.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optCliente_1.Location = New System.Drawing.Point(24, 16)
        Me._optCliente_1.Name = "_optCliente_1"
        Me.COBISResourceProvider.SetResourceID(Me._optCliente_1, "500144")
        Me._optCliente_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCliente_1.Size = New System.Drawing.Size(98, 15)
        Me._optCliente_1.TabIndex = 25
        Me._optCliente_1.TabStop = True
        Me._optCliente_1.Text = "*P.  Jurídica"
        Me._optCliente_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCliente_1, "")
        '
        'lblDesOficina
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDesOficina, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDesOficina, False)
        Me.lblDesOficina.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDesOficina.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDesOficina, "Default")
        Me.lblDesOficina.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDesOficina.Location = New System.Drawing.Point(235, 127)
        Me.lblDesOficina.Name = "lblDesOficina"
        Me.lblDesOficina.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDesOficina.Size = New System.Drawing.Size(43, 20)
        Me.lblDesOficina.TabIndex = 19
        Me.lblDesOficina.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDesOficina, "")
        '
        'il_titulo02
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.il_titulo02, False)
        Me.COBISViewResizer.SetAutoResize(Me.il_titulo02, False)
        Me.il_titulo02.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.il_titulo02.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.il_titulo02, "Default")
        Me.il_titulo02.Cursor = System.Windows.Forms.Cursors.Default
        Me.il_titulo02.Location = New System.Drawing.Point(10, 193)
        Me.il_titulo02.Name = "il_titulo02"
        Me.il_titulo02.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.il_titulo02.Size = New System.Drawing.Size(519, 17)
        Me.il_titulo02.TabIndex = 15
        Me.il_titulo02.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.il_titulo02, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me.FraCliente)
        Me.PFormas.Controls.Add(Me.Frame3D1)
        Me.PFormas.Controls.Add(Me.lblDesOficina)
        Me.PFormas.Controls.Add(Me.txtValor)
        Me.PFormas.Controls.Add(Me.txtOficinaOpt)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_2)
        Me.PFormas.Controls.Add(Me.fraCriterio)
        Me.PFormas.Controls.Add(Me.fraAlianza)
        Me.PFormas.Controls.Add(Me.il_titulo02)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(599, 391)
        Me.PFormas.TabIndex = 24
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdResultados)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 159)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(580, 231)
        Me.GroupBox1.TabIndex = 24
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBEscoger, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(618, 25)
        Me.TSBotones.TabIndex = 25
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
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Navy
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2020")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "500119")
        Me.TSBSiguiente.Size = New System.Drawing.Size(66, 22)
        Me.TSBSiguiente.Text = "*Sig&tes."
        '
        'TSBEscoger
        '
        Me.TSBEscoger.ForeColor = System.Drawing.Color.Navy
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "2021")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "2002")
        Me.TSBEscoger.Size = New System.Drawing.Size(73, 22)
        Me.TSBEscoger.Text = "*&Escoger"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FBuscarClienteClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBuscar_0)
        Me.Controls.Add(Me._cmdBuscar_1)
        Me.Controls.Add(Me.cmdEscoger)
        Me.Controls.Add(Me.cmdSalir)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Silver
        Me.Location = New System.Drawing.Point(-38, 91)
        Me.Name = "FBuscarClienteClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(618, 450)
        Me.Tag = "1318"
        Me.Text = "Búsqueda de Clientes y Prospectos"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.Frame3D1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame3D1.ResumeLayout(False)
        CType(Me.grdResultados, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.fraAlianza, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraAlianza.ResumeLayout(False)
        Me.fraAlianza.PerformLayout()
        CType(Me.fraCriterio, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraCriterio.ResumeLayout(False)
        CType(Me.FraCliente, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FraCliente.ResumeLayout(False)
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
    Sub InitializeoptCriterio()
        Me.optCriterio(3) = _optCriterio_3
        Me.optCriterio(1) = _optCriterio_1
        Me.optCriterio(0) = _optCriterio_0
        Me.optCriterio(2) = _optCriterio_2
    End Sub
    Sub InitializeoptCliente()
        Me.optCliente(0) = _optCliente_0
        Me.optCliente(1) = _optCliente_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(2) = _lblEtiqueta_2
    End Sub
    Sub InitializecmdBuscar()
        Me.cmdBuscar(1) = _cmdBuscar_1
        Me.cmdBuscar(0) = _cmdBuscar_0
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


