Imports COBISCorp.tCOBIS.TADMIN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FMantCatalogoClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtEstado()
		InitializetxtDescripcion()
		InitializelbldEstado()
		InitializelblEstado()
		InitializelblDescripcion()
		InitializelblCodigo()
		InitializeTxtCodigo()
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
    Public WithEvents cmdCancelar As System.Windows.Forms.Button
    Public WithEvents cmdLimpiar As System.Windows.Forms.Button
    Public WithEvents cmdTransmitir As System.Windows.Forms.Button
    Public WithEvents pnlBotones As COBISCorp.Framework.UI.Components.COBISPanel
    Public WithEvents cmdSalir1 As System.Windows.Forms.Button
    Public WithEvents cmdActualizar As System.Windows.Forms.Button
    Public WithEvents cmdIngresar As System.Windows.Forms.Button
    Public WithEvents cmdSiguiente As System.Windows.Forms.Button
    Public WithEvents cmdBuscar As System.Windows.Forms.Button
    Public WithEvents fraBusqueda As Infragistics.Win.Misc.UltraGroupBox
    Public TxtCodigo(0) As System.Windows.Forms.TextBox
    Public lblCodigo(0) As System.Windows.Forms.Label
    Public lblDescripcion(0) As System.Windows.Forms.Label
    Public lblEstado(0) As System.Windows.Forms.Label
    Public lbldEstado(0) As System.Windows.Forms.Label
    Public txtDescripcion(0) As System.Windows.Forms.TextBox
    Public txtEstado(0) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FMantCatalogoClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.pnlBotones = New COBISCorp.Framework.UI.Components.COBISPanel()
        Me.cmdCancelar = New System.Windows.Forms.Button()
        Me.cmdLimpiar = New System.Windows.Forms.Button()
        Me.cmdTransmitir = New System.Windows.Forms.Button()
        Me.fraBusqueda = New Infragistics.Win.Misc.UltraGroupBox()
        Me.cboTabla = New System.Windows.Forms.ComboBox()
        Me.cmdSalir1 = New System.Windows.Forms.Button()
        Me.cmdActualizar = New System.Windows.Forms.Button()
        Me.cmdIngresar = New System.Windows.Forms.Button()
        Me.cmdSiguiente = New System.Windows.Forms.Button()
        Me.cmdBuscar = New System.Windows.Forms.Button()
        Me.grdValores = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.il_tabla = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.fraCatalogo = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtEstado_0 = New System.Windows.Forms.TextBox()
        Me._txtDescripcion_0 = New System.Windows.Forms.TextBox()
        Me._TxtCodigo_0 = New System.Windows.Forms.TextBox()
        Me._lbldEstado_0 = New System.Windows.Forms.Label()
        Me._lblEstado_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblCodigo_0 = New System.Windows.Forms.Label()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBIngresar = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.TSBCancelar = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.pnlBotones.SuspendLayout()
        CType(Me.fraBusqueda, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraBusqueda.SuspendLayout()
        CType(Me.grdValores, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        Me.GroupBox1.SuspendLayout()
        CType(Me.fraCatalogo, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraCatalogo.SuspendLayout()
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
        'pnlBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.pnlBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.pnlBotones, False)
        Me.pnlBotones.BackColor = System.Drawing.SystemColors.Control
        Me.pnlBotones.Controls.Add(Me.cmdCancelar)
        Me.pnlBotones.Controls.Add(Me.cmdLimpiar)
        Me.pnlBotones.Controls.Add(Me.cmdTransmitir)
        Me.COBISStyleProvider.SetControlStyle(Me.pnlBotones, "Default")
        Me.pnlBotones.FloodColor = System.Drawing.Color.Empty
        Me.pnlBotones.FloodPercent = CType(0, Short)
        Me.pnlBotones.Location = New System.Drawing.Point(-624, 295)
        Me.pnlBotones.Name = "pnlBotones"
        Me.pnlBotones.Size = New System.Drawing.Size(621, 57)
        Me.pnlBotones.TabIndex = 13
        Me.pnlBotones.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.pnlBotones.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.pnlBotones, "")
        '
        'cmdCancelar
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdCancelar, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdCancelar, False)
        Me.cmdCancelar.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdCancelar, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdCancelar, True)
        Me.cmdCancelar.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdCancelar, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdCancelar, Nothing)
        Me.cmdCancelar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCancelar.Image = CType(resources.GetObject("cmdCancelar.Image"), System.Drawing.Image)
        Me.cmdCancelar.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me.cmdCancelar.Location = New System.Drawing.Point(554, 2)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdCancelar, System.Drawing.Color.Silver)
        Me.cmdCancelar.Name = "cmdCancelar"
        Me.cmdCancelar.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCancelar.Size = New System.Drawing.Size(65, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdCancelar, 1)
        Me.cmdCancelar.TabIndex = 20
        Me.cmdCancelar.TabStop = False
        Me.cmdCancelar.Text = "&Salir"
        Me.cmdCancelar.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdCancelar.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdCancelar.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdCancelar, "")
        '
        'cmdLimpiar
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdLimpiar, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdLimpiar, False)
        Me.cmdLimpiar.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdLimpiar, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdLimpiar, True)
        Me.cmdLimpiar.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdLimpiar, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdLimpiar, Nothing)
        Me.cmdLimpiar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdLimpiar.Image = CType(resources.GetObject("cmdLimpiar.Image"), System.Drawing.Image)
        Me.cmdLimpiar.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me.cmdLimpiar.Location = New System.Drawing.Point(490, 2)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdLimpiar, System.Drawing.Color.Silver)
        Me.cmdLimpiar.Name = "cmdLimpiar"
        Me.cmdLimpiar.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdLimpiar.Size = New System.Drawing.Size(65, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdLimpiar, 1)
        Me.cmdLimpiar.TabIndex = 19
        Me.cmdLimpiar.TabStop = False
        Me.cmdLimpiar.Text = "&Limpiar"
        Me.cmdLimpiar.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdLimpiar.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdLimpiar.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdLimpiar, "")
        '
        'cmdTransmitir
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdTransmitir, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdTransmitir, False)
        Me.cmdTransmitir.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdTransmitir, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdTransmitir, True)
        Me.cmdTransmitir.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdTransmitir, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdTransmitir, Nothing)
        Me.cmdTransmitir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdTransmitir.Image = CType(resources.GetObject("cmdTransmitir.Image"), System.Drawing.Image)
        Me.cmdTransmitir.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me.cmdTransmitir.Location = New System.Drawing.Point(426, 2)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdTransmitir, System.Drawing.Color.Silver)
        Me.cmdTransmitir.Name = "cmdTransmitir"
        Me.cmdTransmitir.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdTransmitir.Size = New System.Drawing.Size(65, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdTransmitir, 1)
        Me.cmdTransmitir.TabIndex = 18
        Me.cmdTransmitir.TabStop = False
        Me.cmdTransmitir.Text = "&Transmitir"
        Me.cmdTransmitir.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdTransmitir.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdTransmitir.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdTransmitir, "")
        '
        'fraBusqueda
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraBusqueda, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraBusqueda, False)
        Me.fraBusqueda.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraBusqueda.Controls.Add(Me.cboTabla)
        Me.fraBusqueda.Controls.Add(Me.cmdSalir1)
        Me.fraBusqueda.Controls.Add(Me.cmdActualizar)
        Me.fraBusqueda.Controls.Add(Me.cmdIngresar)
        Me.fraBusqueda.Controls.Add(Me.cmdSiguiente)
        Me.fraBusqueda.Controls.Add(Me.cmdBuscar)
        Me.fraBusqueda.Controls.Add(Me.grdValores)
        Me.fraBusqueda.Controls.Add(Me.il_tabla)
        Me.COBISStyleProvider.SetControlStyle(Me.fraBusqueda, "Default")
        Me.fraBusqueda.ForeColor = System.Drawing.Color.Navy
        Me.fraBusqueda.Location = New System.Drawing.Point(5, 15)
        Me.fraBusqueda.Name = "fraBusqueda"
        Me.fraBusqueda.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraBusqueda.Size = New System.Drawing.Size(556, 341)
        Me.fraBusqueda.TabIndex = 11
        Me.fraBusqueda.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraBusqueda, "")
        '
        'cboTabla
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cboTabla, False)
        Me.COBISViewResizer.SetAutoResize(Me.cboTabla, False)
        Me.cboTabla.BackColor = System.Drawing.Color.White
        Me.COBISStyleProvider.SetControlStyle(Me.cboTabla, "Default")
        Me.cboTabla.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboTabla.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboTabla.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboTabla.Location = New System.Drawing.Point(126, 7)
        Me.cboTabla.Name = "cboTabla"
        Me.cboTabla.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboTabla.Size = New System.Drawing.Size(204, 20)
        Me.cboTabla.Sorted = True
        Me.cboTabla.TabIndex = 0
        Me.cboTabla.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cboTabla, "")
        '
        'cmdSalir1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdSalir1, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdSalir1, False)
        Me.cmdSalir1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdSalir1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdSalir1, True)
        Me.cmdSalir1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdSalir1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdSalir1, Nothing)
        Me.cmdSalir1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSalir1.Image = CType(resources.GetObject("cmdSalir1.Image"), System.Drawing.Image)
        Me.cmdSalir1.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me.cmdSalir1.Location = New System.Drawing.Point(-560, 296)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSalir1, System.Drawing.Color.Silver)
        Me.cmdSalir1.Name = "cmdSalir1"
        Me.cmdSalir1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSalir1.Size = New System.Drawing.Size(58, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdSalir1, 1)
        Me.cmdSalir1.TabIndex = 4
        Me.cmdSalir1.TabStop = False
        Me.cmdSalir1.Text = "&Salir"
        Me.cmdSalir1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdSalir1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSalir1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSalir1, "")
        '
        'cmdActualizar
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdActualizar, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdActualizar, False)
        Me.cmdActualizar.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdActualizar, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdActualizar, True)
        Me.cmdActualizar.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdActualizar, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdActualizar, Nothing)
        Me.cmdActualizar.Enabled = False
        Me.cmdActualizar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdActualizar.Image = CType(resources.GetObject("cmdActualizar.Image"), System.Drawing.Image)
        Me.cmdActualizar.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me.cmdActualizar.Location = New System.Drawing.Point(-560, 243)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdActualizar, System.Drawing.Color.Silver)
        Me.cmdActualizar.Name = "cmdActualizar"
        Me.cmdActualizar.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdActualizar.Size = New System.Drawing.Size(65, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdActualizar, 1)
        Me.cmdActualizar.TabIndex = 3
        Me.cmdActualizar.TabStop = False
        Me.cmdActualizar.Tag = "585"
        Me.cmdActualizar.Text = "&Actualizar"
        Me.cmdActualizar.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdActualizar.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdActualizar.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdActualizar, "")
        '
        'cmdIngresar
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdIngresar, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdIngresar, False)
        Me.cmdIngresar.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdIngresar, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdIngresar, True)
        Me.cmdIngresar.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdIngresar, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdIngresar, Nothing)
        Me.cmdIngresar.Enabled = False
        Me.cmdIngresar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdIngresar.Image = CType(resources.GetObject("cmdIngresar.Image"), System.Drawing.Image)
        Me.cmdIngresar.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me.cmdIngresar.Location = New System.Drawing.Point(-560, 190)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdIngresar, System.Drawing.Color.Silver)
        Me.cmdIngresar.Name = "cmdIngresar"
        Me.cmdIngresar.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdIngresar.Size = New System.Drawing.Size(65, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdIngresar, 1)
        Me.cmdIngresar.TabIndex = 2
        Me.cmdIngresar.TabStop = False
        Me.cmdIngresar.Tag = "584"
        Me.cmdIngresar.Text = "&Crear"
        Me.cmdIngresar.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdIngresar.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdIngresar.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdIngresar, "")
        '
        'cmdSiguiente
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdSiguiente, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdSiguiente, False)
        Me.cmdSiguiente.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdSiguiente, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdSiguiente, True)
        Me.cmdSiguiente.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdSiguiente, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdSiguiente, Nothing)
        Me.cmdSiguiente.Enabled = False
        Me.cmdSiguiente.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSiguiente.Image = CType(resources.GetObject("cmdSiguiente.Image"), System.Drawing.Image)
        Me.cmdSiguiente.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me.cmdSiguiente.Location = New System.Drawing.Point(-560, 137)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSiguiente, System.Drawing.Color.Silver)
        Me.cmdSiguiente.Name = "cmdSiguiente"
        Me.cmdSiguiente.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSiguiente.Size = New System.Drawing.Size(65, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdSiguiente, 1)
        Me.cmdSiguiente.TabIndex = 6
        Me.cmdSiguiente.TabStop = False
        Me.cmdSiguiente.Tag = "1564;1222;1209;1389"
        Me.cmdSiguiente.Text = "Siguiente"
        Me.cmdSiguiente.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdSiguiente.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSiguiente.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSiguiente, "")
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
        Me.cmdBuscar.Enabled = False
        Me.cmdBuscar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdBuscar.Image = CType(resources.GetObject("cmdBuscar.Image"), System.Drawing.Image)
        Me.cmdBuscar.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me.cmdBuscar.Location = New System.Drawing.Point(-560, 85)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdBuscar, System.Drawing.Color.Silver)
        Me.cmdBuscar.Name = "cmdBuscar"
        Me.cmdBuscar.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdBuscar.Size = New System.Drawing.Size(65, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdBuscar, 1)
        Me.cmdBuscar.TabIndex = 5
        Me.cmdBuscar.TabStop = False
        Me.cmdBuscar.Tag = "1564;1222;1209;1389"
        Me.cmdBuscar.Text = "&Buscar"
        Me.cmdBuscar.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdBuscar.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdBuscar.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdBuscar, "")
        '
        'grdValores
        '
        Me.grdValores._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdValores, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdValores, False)
        Me.grdValores.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdValores.Clip = ""
        Me.grdValores.Col = CType(1, Short)
        Me.grdValores.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdValores.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdValores.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdValores, "Default")
        Me.grdValores.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdValores, True)
        Me.grdValores.FixedCols = CType(1, Short)
        Me.grdValores.FixedRows = CType(1, Short)
        Me.grdValores.ForeColor = System.Drawing.Color.Black
        Me.grdValores.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdValores.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdValores.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdValores.HighLight = True
        Me.grdValores.Location = New System.Drawing.Point(10, 31)
        Me.grdValores.Name = "grdValores"
        Me.grdValores.Picture = Nothing
        Me.grdValores.Row = CType(1, Short)
        Me.grdValores.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdValores.Size = New System.Drawing.Size(540, 299)
        Me.grdValores.Sort = CType(2, Short)
        Me.grdValores.TabIndex = 1
        Me.grdValores.TabStop = False
        Me.grdValores.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdValores, "")
        '
        'il_tabla
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.il_tabla, False)
        Me.COBISViewResizer.SetAutoResize(Me.il_tabla, False)
        Me.il_tabla.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.il_tabla, "Default")
        Me.il_tabla.Cursor = System.Windows.Forms.Cursors.Default
        Me.il_tabla.ForeColor = System.Drawing.Color.Navy
        Me.il_tabla.Location = New System.Drawing.Point(10, 10)
        Me.il_tabla.Name = "il_tabla"
        Me.COBISResourceProvider.SetResourceID(Me.il_tabla, "502613")
        Me.il_tabla.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.il_tabla.Size = New System.Drawing.Size(116, 20)
        Me.il_tabla.TabIndex = 14
        Me.il_tabla.Text = "*Tablas de Catálogo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.il_tabla, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(583, 396)
        Me.PFormas.TabIndex = 14
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.Add(Me.fraCatalogo)
        Me.GroupBox1.Controls.Add(Me.fraBusqueda)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(567, 347)
        Me.GroupBox1.TabIndex = 12
        Me.GroupBox1.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'fraCatalogo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraCatalogo, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraCatalogo, False)
        Me.fraCatalogo.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraCatalogo.Controls.Add(Me._txtEstado_0)
        Me.fraCatalogo.Controls.Add(Me._txtDescripcion_0)
        Me.fraCatalogo.Controls.Add(Me._TxtCodigo_0)
        Me.fraCatalogo.Controls.Add(Me._lbldEstado_0)
        Me.fraCatalogo.Controls.Add(Me._lblEstado_0)
        Me.fraCatalogo.Controls.Add(Me._lblDescripcion_0)
        Me.fraCatalogo.Controls.Add(Me._lblCodigo_0)
        Me.COBISStyleProvider.SetControlStyle(Me.fraCatalogo, "Default")
        Me.fraCatalogo.ForeColor = System.Drawing.Color.Navy
        Me.fraCatalogo.Location = New System.Drawing.Point(5, 127)
        Me.fraCatalogo.Name = "fraCatalogo"
        Me.COBISResourceProvider.SetResourceID(Me.fraCatalogo, "3002")
        Me.fraCatalogo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraCatalogo.Size = New System.Drawing.Size(556, 177)
        Me.fraCatalogo.TabIndex = 10
        Me.fraCatalogo.Text = "*Datos Generales"
        Me.fraCatalogo.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.fraCatalogo.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraCatalogo, "")
        '
        '_txtEstado_0
        '
        Me._txtEstado_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtEstado_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtEstado_0, False)
        Me._txtEstado_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtEstado_0, "Default")
        Me._txtEstado_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtEstado_0.Location = New System.Drawing.Point(100, 107)
        Me._txtEstado_0.MaxLength = 1
        Me._txtEstado_0.Name = "_txtEstado_0"
        Me._txtEstado_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtEstado_0.Size = New System.Drawing.Size(25, 18)
        Me._txtEstado_0.TabIndex = 1
        Me._txtEstado_0.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtEstado_0, "")
        '
        '_txtDescripcion_0
        '
        Me._txtDescripcion_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtDescripcion_0, False)
        Me._txtDescripcion_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtDescripcion_0, "Default")
        Me._txtDescripcion_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtDescripcion_0.Location = New System.Drawing.Point(100, 84)
        Me._txtDescripcion_0.MaxLength = 64
        Me._txtDescripcion_0.Name = "_txtDescripcion_0"
        Me._txtDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtDescripcion_0.Size = New System.Drawing.Size(450, 18)
        Me._txtDescripcion_0.TabIndex = 0
        Me._txtDescripcion_0.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtDescripcion_0, "")
        '
        '_TxtCodigo_0
        '
        Me._TxtCodigo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._TxtCodigo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._TxtCodigo_0, False)
        Me._TxtCodigo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._TxtCodigo_0, "Default")
        Me._TxtCodigo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._TxtCodigo_0.Location = New System.Drawing.Point(100, 64)
        Me._TxtCodigo_0.MaxLength = 10
        Me._TxtCodigo_0.Name = "_TxtCodigo_0"
        Me._TxtCodigo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._TxtCodigo_0.Size = New System.Drawing.Size(119, 18)
        Me._TxtCodigo_0.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._TxtCodigo_0, "")
        '
        '_lbldEstado_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbldEstado_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbldEstado_0, False)
        Me._lbldEstado_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lbldEstado_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lbldEstado_0, "Default")
        Me._lbldEstado_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbldEstado_0.Location = New System.Drawing.Point(134, 107)
        Me._lbldEstado_0.Name = "_lbldEstado_0"
        Me._lbldEstado_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbldEstado_0.Size = New System.Drawing.Size(195, 21)
        Me._lbldEstado_0.TabIndex = 17
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbldEstado_0, "")
        '
        '_lblEstado_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEstado_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEstado_0, False)
        Me._lblEstado_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEstado_0, "Default")
        Me._lblEstado_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEstado_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEstado_0.Location = New System.Drawing.Point(23, 108)
        Me._lblEstado_0.Name = "_lblEstado_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEstado_0, "5067")
        Me._lblEstado_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEstado_0.Size = New System.Drawing.Size(68, 20)
        Me._lblEstado_0.TabIndex = 16
        Me._lblEstado_0.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEstado_0, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.ForeColor = System.Drawing.Color.Navy
        Me._lblDescripcion_0.Location = New System.Drawing.Point(22, 84)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblDescripcion_0, "500643")
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(68, 20)
        Me._lblDescripcion_0.TabIndex = 12
        Me._lblDescripcion_0.Text = "*Descripción:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblCodigo_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblCodigo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblCodigo_0, False)
        Me._lblCodigo_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblCodigo_0, "Default")
        Me._lblCodigo_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblCodigo_0.ForeColor = System.Drawing.Color.Navy
        Me._lblCodigo_0.Location = New System.Drawing.Point(23, 64)
        Me._lblCodigo_0.Name = "_lblCodigo_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblCodigo_0, "500025")
        Me._lblCodigo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblCodigo_0.Size = New System.Drawing.Size(68, 20)
        Me._lblCodigo_0.TabIndex = 15
        Me._lblCodigo_0.Text = "*Código:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblCodigo_0, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBIngresar, Me.TSBActualizar, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir, Me.TSBCancelar})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(605, 25)
        Me.TSBotones.TabIndex = 15
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
        Me.TSBBuscar.Size = New System.Drawing.Size(65, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2001")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "2044")
        Me.TSBSiguiente.Size = New System.Drawing.Size(77, 22)
        Me.TSBSiguiente.Text = "*Siguiente"
        '
        'TSBIngresar
        '
        Me.TSBIngresar.ForeColor = System.Drawing.Color.Black
        Me.TSBIngresar.Image = CType(resources.GetObject("TSBIngresar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBIngresar, "2030")
        Me.TSBIngresar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBIngresar.Name = "TSBIngresar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBIngresar, "2030")
        Me.TSBIngresar.Size = New System.Drawing.Size(60, 22)
        Me.TSBIngresar.Text = "*&Crear"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.ForeColor = System.Drawing.Color.Black
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "2005")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "2031")
        Me.TSBActualizar.Size = New System.Drawing.Size(80, 22)
        Me.TSBActualizar.Text = "*&Actualizar"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(80, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(66, 22)
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
        Me.TSBSalir.Size = New System.Drawing.Size(53, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'TSBCancelar
        '
        Me.TSBCancelar.ForeColor = System.Drawing.Color.Black
        Me.TSBCancelar.Image = CType(resources.GetObject("TSBCancelar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCancelar, "2008")
        Me.TSBCancelar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCancelar.Name = "TSBCancelar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCancelar, "2008")
        Me.TSBCancelar.Size = New System.Drawing.Size(53, 22)
        Me.TSBCancelar.Text = "*&Salir"
        '
        'FMantCatalogoClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.pnlBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Silver
        Me.Location = New System.Drawing.Point(20, 154)
        Me.Name = "FMantCatalogoClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(605, 435)
        Me.Text = "Creación y Actualización de Tablas de Referencias"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.pnlBotones.ResumeLayout(False)
        CType(Me.fraBusqueda, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraBusqueda.ResumeLayout(False)
        CType(Me.grdValores, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.fraCatalogo, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraCatalogo.ResumeLayout(False)
        Me.fraCatalogo.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtEstado()
        Me.txtEstado(0) = _txtEstado_0
    End Sub
    Sub InitializetxtDescripcion()
        Me.txtDescripcion(0) = _txtDescripcion_0
    End Sub
    Sub InitializelbldEstado()
        Me.lbldEstado(0) = _lbldEstado_0
    End Sub
    Sub InitializelblEstado()
        Me.lblEstado(0) = _lblEstado_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializelblCodigo()
        Me.lblCodigo(0) = _lblCodigo_0
    End Sub
    Sub InitializeTxtCodigo()
        Me.TxtCodigo(0) = _TxtCodigo_0
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBIngresar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Public WithEvents il_tabla As System.Windows.Forms.Label
    Public WithEvents cboTabla As System.Windows.Forms.ComboBox
    Public WithEvents grdValores As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents fraCatalogo As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtEstado_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtDescripcion_0 As System.Windows.Forms.TextBox
    Private WithEvents _TxtCodigo_0 As System.Windows.Forms.TextBox
    Private WithEvents _lbldEstado_0 As System.Windows.Forms.Label
    Private WithEvents _lblEstado_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblCodigo_0 As System.Windows.Forms.Label
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents TSBCancelar As System.Windows.Forms.ToolStripButton
#End Region 
End Class


