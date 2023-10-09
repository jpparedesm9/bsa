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
    Private WithEvents _optCliente_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optCliente_1 As System.Windows.Forms.RadioButton
    Public WithEvents fraCliente As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _optCriterio_3 As System.Windows.Forms.RadioButton
    Private WithEvents _optCriterio_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optCriterio_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optCriterio_2 As System.Windows.Forms.RadioButton
    Public WithEvents fraCriterio As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _lblEtiqueta_2 As COBISCorp.Framework.UI.Components.COBISPanel
    Public WithEvents txtOficinaOpt As System.Windows.Forms.TextBox
    Public WithEvents txtAlianza As System.Windows.Forms.TextBox
    Private WithEvents _lblEtiqueta_1 As COBISCorp.Framework.UI.Components.COBISPanel
    Public WithEvents lblAlianza As COBISCorp.Framework.UI.Components.COBISPanel
    Public WithEvents fraAlianza As Infragistics.Win.Misc.UltraGroupBox
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
        Me.components = New System.ComponentModel.Container
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FBuscarClienteClass))
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Frame3D1 = New Infragistics.Win.Misc.UltraGroupBox
        Me.OptionAmbos = New System.Windows.Forms.RadioButton
        Me.OptionProspecto = New System.Windows.Forms.RadioButton
        Me.OptionCliente = New System.Windows.Forms.RadioButton
        Me.chkClientes = New System.Windows.Forms.CheckBox
        Me.chkProspecto = New System.Windows.Forms.CheckBox
        Me.grdResultados = New COBISCorp.Framework.UI.Components.COBISGrid
        Me.txtValor = New System.Windows.Forms.TextBox
        Me._lblEtiqueta_0 = New COBISCorp.Framework.UI.Components.COBISPanel
        Me.cmdSalir = New System.Windows.Forms.Button
        Me.cmdEscoger = New System.Windows.Forms.Button
        Me._cmdBuscar_1 = New System.Windows.Forms.Button
        Me._cmdBuscar_0 = New System.Windows.Forms.Button
        Me.fraCliente = New Infragistics.Win.Misc.UltraGroupBox
        Me._optCliente_0 = New System.Windows.Forms.RadioButton
        Me._optCliente_1 = New System.Windows.Forms.RadioButton
        Me.fraCriterio = New Infragistics.Win.Misc.UltraGroupBox
        Me._optCriterio_3 = New System.Windows.Forms.RadioButton
        Me._optCriterio_1 = New System.Windows.Forms.RadioButton
        Me._optCriterio_0 = New System.Windows.Forms.RadioButton
        Me._optCriterio_2 = New System.Windows.Forms.RadioButton
        Me._lblEtiqueta_2 = New COBISCorp.Framework.UI.Components.COBISPanel
        Me.txtOficinaOpt = New System.Windows.Forms.TextBox
        Me.fraAlianza = New Infragistics.Win.Misc.UltraGroupBox
        Me.txtAlianza = New System.Windows.Forms.TextBox
        Me._lblEtiqueta_1 = New COBISCorp.Framework.UI.Components.COBISPanel
        Me.lblAlianza = New COBISCorp.Framework.UI.Components.COBISPanel
        Me.lblDesOficina = New System.Windows.Forms.Label
        Me.il_titulo02 = New System.Windows.Forms.Label
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.TSBotones = New System.Windows.Forms.ToolStrip
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton
        Me.PForma = New Infragistics.Win.Misc.UltraGroupBox
        Me.Frame3D1.SuspendLayout()
        CType(Me.grdResultados, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraCliente.SuspendLayout()
        Me.fraCriterio.SuspendLayout()
        Me.fraAlianza.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TSBotones.SuspendLayout()
        Me.PForma.SuspendLayout()
        Me.Pforma = New Infragistics.Win.Misc.UltraGroupBox
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Pforma.SuspendLayout()
        Me.SuspendLayout()
        Me.COBISViewResizer.ContainerForm = Me
        '
        'Pforma
        '
        Me.Pforma.Controls.Add(Me.txtValor)
        Me.Pforma.Controls.Add(Me.PForma)
        Me.Pforma.Controls.Add(Me.TSBotones)
        Me.Pforma.Controls.Add(Me.cmdSalir)
        Me.Pforma.Controls.Add(Me.cmdEscoger)
        Me.Pforma.Controls.Add(Me._cmdBuscar_1)
        Me.Pforma.Controls.Add(Me._cmdBuscar_0)
        Me.Pforma.Controls.Add(Me.il_titulo02)
        Me.Pforma.Controls.Add(Me._lblEtiqueta_2)
        Me.Pforma.Controls.Add(Me.txtOficinaOpt)
        Me.Pforma.Controls.Add(Me.lblDesOficina)
        Me.Pforma.Location = New System.Drawing.Point(0, 0)
        Me.Pforma.Name = "Pforma"
        Me.Pforma.Size = New System.Drawing.Size(630, 581)
        Me.Pforma.TabIndex = 0
        Me.Pforma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        'COBISResourceProvider
        '
        Me.COBISResourceProvider.SetImageID(Me.COBISResourceProvider, "")
        Me.COBISResourceProvider.SetResourceID(Me.COBISResourceProvider, "")
        '
        'ToolTip1
        '
        Me.COBISResourceProvider.SetImageID(Me.ToolTip1, "")
        Me.COBISResourceProvider.SetResourceID(Me.ToolTip1, "")
        '
        'Frame3D1
        '
        Me.Frame3D1.BackColor = System.Drawing.Color.FromArgb(205,222,240)
        Me.Frame3D1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.Frame3D1.Controls.Add(Me.OptionAmbos)
        Me.Frame3D1.Controls.Add(Me.OptionProspecto)
        Me.Frame3D1.Controls.Add(Me.OptionCliente)
        Me.Frame3D1.Controls.Add(Me.chkClientes)
        Me.Frame3D1.Controls.Add(Me.chkProspecto)
        Me.Frame3D1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.17!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame3D1.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.Frame3D1, "")
        Me.Frame3D1.Location = New System.Drawing.Point(240, 3)
        Me.Frame3D1.Name = "Frame3D1"
        Me.COBISResourceProvider.SetResourceID(Me.Frame3D1, "")
        Me.Frame3D1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame3D1.Size = New System.Drawing.Size(348, 35)
        Me.Frame3D1.TabIndex = 22
        Me.Frame3D1.TabStop = False
        Me.Frame3D1.Text = "Buscar"
        Me.Frame3D1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        'OptionAmbos
        '
        Me.OptionAmbos.BackColor = System.Drawing.Color.Transparent
        Me.OptionAmbos.Checked = True
        Me.OptionAmbos.Cursor = System.Windows.Forms.Cursors.Default
        Me.OptionAmbos.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.OptionAmbos.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me.OptionAmbos, "")
        Me.OptionAmbos.Location = New System.Drawing.Point(224, 12)
        Me.OptionAmbos.Name = "OptionAmbos"
        Me.COBISResourceProvider.SetResourceID(Me.OptionAmbos, "")
        Me.OptionAmbos.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.OptionAmbos.Size = New System.Drawing.Size(60, 17)
        Me.OptionAmbos.TabIndex = 4
        Me.OptionAmbos.TabStop = True
        Me.OptionAmbos.Text = "Todos"
        Me.OptionAmbos.UseVisualStyleBackColor = True
        '
        'OptionProspecto
        '
        Me.OptionProspecto.BackColor = System.Drawing.Color.Transparent
        Me.OptionProspecto.Cursor = System.Windows.Forms.Cursors.Default
        Me.OptionProspecto.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.OptionProspecto.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me.OptionProspecto, "")
        Me.OptionProspecto.Location = New System.Drawing.Point(131, 12)
        Me.OptionProspecto.Name = "OptionProspecto"
        Me.COBISResourceProvider.SetResourceID(Me.OptionProspecto, "")
        Me.OptionProspecto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.OptionProspecto.Size = New System.Drawing.Size(80, 17)
        Me.OptionProspecto.TabIndex = 3
        Me.OptionProspecto.TabStop = True
        Me.OptionProspecto.Text = "Prospectos"
        Me.OptionProspecto.UseVisualStyleBackColor = True
        '
        'OptionCliente
        '
        Me.OptionCliente.BackColor = System.Drawing.Color.Transparent
        Me.OptionCliente.Cursor = System.Windows.Forms.Cursors.Default
        Me.OptionCliente.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold)
        Me.OptionCliente.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me.OptionCliente, "")
        Me.OptionCliente.Location = New System.Drawing.Point(23, 14)
        Me.OptionCliente.Name = "OptionCliente"
        Me.COBISResourceProvider.SetResourceID(Me.OptionCliente, "")
        Me.OptionCliente.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.OptionCliente.Size = New System.Drawing.Size(64, 16)
        Me.OptionCliente.TabIndex = 2
        Me.OptionCliente.TabStop = True
        Me.OptionCliente.Text = "Clientes"
        Me.OptionCliente.UseVisualStyleBackColor = True
        '
        'chkClientes
        '
        Me.chkClientes.BackColor = System.Drawing.Color.Transparent
        Me.chkClientes.Checked = True
        Me.chkClientes.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkClientes.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkClientes.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkClientes.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me.chkClientes, "")
        Me.chkClientes.Location = New System.Drawing.Point(116, 35)
        Me.chkClientes.Name = "chkClientes"
        Me.COBISResourceProvider.SetResourceID(Me.chkClientes, "")
        Me.chkClientes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkClientes.Size = New System.Drawing.Size(67, 14)
        Me.chkClientes.TabIndex = 24
        Me.chkClientes.Text = "Clientes"
        Me.chkClientes.UseVisualStyleBackColor = True
        Me.chkClientes.Visible = False
        '
        'chkProspecto
        '
        Me.chkProspecto.BackColor = System.Drawing.Color.Transparent
        Me.chkProspecto.Checked = True
        Me.chkProspecto.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkProspecto.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkProspecto.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkProspecto.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me.chkProspecto, "")
        Me.chkProspecto.Location = New System.Drawing.Point(23, 35)
        Me.chkProspecto.Name = "chkProspecto"
        Me.COBISResourceProvider.SetResourceID(Me.chkProspecto, "")
        Me.chkProspecto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkProspecto.Size = New System.Drawing.Size(81, 14)
        Me.chkProspecto.TabIndex = 23
        Me.chkProspecto.Text = "Prospectos"
        Me.chkProspecto.UseVisualStyleBackColor = True
        Me.chkProspecto.Visible = False
        '
        'grdResultados
        '
        Me.grdResultados._Text = ""
        Me.grdResultados.BackgroundColor = System.Drawing.Color.FromArgb(240,246,250)
        Me.grdResultados.Clip = ""
        Me.grdResultados.Col = CType(1, Short)
        Me.grdResultados.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdResultados.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdResultados.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.grdResultados.CtlText = ""
        Me.grdResultados.FixedCols = CType(1, Short)
        Me.grdResultados.FixedRows = CType(1, Short)
        Me.grdResultados.ForeColor = System.Drawing.Color.Black
        Me.grdResultados.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdResultados.HighLight = True
        Me.COBISResourceProvider.SetImageID(Me.grdResultados, "")
        Me.grdResultados.Location = New System.Drawing.Point(3, 154)
        Me.grdResultados.Name = "grdResultados"
        Me.grdResultados.Picture = Nothing
        Me.COBISResourceProvider.SetResourceID(Me.grdResultados, "")
        Me.grdResultados.Row = CType(1, Short)
        Me.grdResultados.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdResultados.Size = New System.Drawing.Size(585, 202)
        Me.grdResultados.Sort = CType(2, Short)
        Me.grdResultados.TabIndex = 13
        Me.grdResultados.TopRow = CType(1, Short)
        '
        'txtValor
        '
        Me.txtValor.AcceptsReturn = True
        Me.txtValor.BackColor = System.Drawing.SystemColors.Window
        Me.txtValor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.txtValor.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtValor.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtValor.ForeColor = System.Drawing.SystemColors.WindowText
        Me.COBISResourceProvider.SetImageID(Me.txtValor, "")
        Me.txtValor.Location = New System.Drawing.Point(132, 163)
        Me.txtValor.MaxLength = 0
        Me.txtValor.Name = "txtValor"
        Me.COBISResourceProvider.SetResourceID(Me.txtValor, "")
        Me.txtValor.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtValor.Size = New System.Drawing.Size(466, 20)
        Me.txtValor.TabIndex = 8
        Me.txtValor.Text = "%"
        '
        '_lblEtiqueta_0
        '
        Me._lblEtiqueta_0.BackColor = System.Drawing.SystemColors.Control
        Me._lblEtiqueta_0.FloodColor = System.Drawing.Color.Blue
        Me._lblEtiqueta_0.FloodPercent = CType(0, Short)
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me._lblEtiqueta_0, "")
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(3, 128)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "")
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(118, 20)
        Me._lblEtiqueta_0.TabIndex = 18
        Me._lblEtiqueta_0.Text = "Valor de Búsqueda:"
        Me._lblEtiqueta_0.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'cmdSalir
        '
        Me.cmdSalir.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdSalir, True)
        Me.cmdSalir.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdSalir, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdSalir, Nothing)
        Me.cmdSalir.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSalir.Image = CType(resources.GetObject("cmdSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.cmdSalir, "")
        Me.cmdSalir.Location = New System.Drawing.Point(435, 329)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSalir, System.Drawing.Color.Silver)
        Me.cmdSalir.Name = "cmdSalir"
        Me.COBISResourceProvider.SetResourceID(Me.cmdSalir, "")
        Me.cmdSalir.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSalir.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdSalir, 1)
        Me.cmdSalir.TabIndex = 12
        Me.cmdSalir.Text = "&Salir"
        Me.cmdSalir.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSalir.UseVisualStyleBackColor = True
        '
        'cmdEscoger
        '
        Me.cmdEscoger.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdEscoger, True)
        Me.cmdEscoger.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdEscoger, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdEscoger, Nothing)
        Me.cmdEscoger.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdEscoger.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdEscoger.Image = CType(resources.GetObject("cmdEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.cmdEscoger, "")
        Me.cmdEscoger.Location = New System.Drawing.Point(435, 272)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdEscoger, System.Drawing.Color.Silver)
        Me.cmdEscoger.Name = "cmdEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.cmdEscoger, "")
        Me.cmdEscoger.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdEscoger.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me.cmdEscoger, 1)
        Me.cmdEscoger.TabIndex = 11
        Me.cmdEscoger.Text = "&Escoger"
        Me.cmdEscoger.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdEscoger.UseVisualStyleBackColor = True
        '
        '_cmdBuscar_1
        '
        Me._cmdBuscar_1.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBuscar_1, True)
        Me._cmdBuscar_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBuscar_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBuscar_1, Nothing)
        Me._cmdBuscar_1.Enabled = False
        Me._cmdBuscar_1.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBuscar_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBuscar_1.Image = CType(resources.GetObject("_cmdBuscar_1.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me._cmdBuscar_1, "")
        Me._cmdBuscar_1.Location = New System.Drawing.Point(435, 214)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBuscar_1, System.Drawing.Color.Silver)
        Me._cmdBuscar_1.Name = "_cmdBuscar_1"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBuscar_1, "")
        Me._cmdBuscar_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBuscar_1.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBuscar_1, 1)
        Me._cmdBuscar_1.TabIndex = 10
        Me._cmdBuscar_1.Text = "Si&guiente"
        Me._cmdBuscar_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBuscar_1.UseVisualStyleBackColor = True
        '
        '_cmdBuscar_0
        '
        Me._cmdBuscar_0.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBuscar_0, True)
        Me._cmdBuscar_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBuscar_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBuscar_0, Nothing)
        Me._cmdBuscar_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBuscar_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBuscar_0.Image = CType(resources.GetObject("_cmdBuscar_0.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me._cmdBuscar_0, "")
        Me._cmdBuscar_0.Location = New System.Drawing.Point(435, 154)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBuscar_0, System.Drawing.Color.Silver)
        Me._cmdBuscar_0.Name = "_cmdBuscar_0"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBuscar_0, "")
        Me._cmdBuscar_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBuscar_0.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBuscar_0, 1)
        Me._cmdBuscar_0.TabIndex = 9
        Me._cmdBuscar_0.Tag = "1182;1241;1318"
        Me._cmdBuscar_0.Text = "&Buscar"
        Me._cmdBuscar_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBuscar_0.UseVisualStyleBackColor = True
        '
        'fraCliente
        '
        Me.fraCliente.BackColor = System.Drawing.Color.FromArgb(205,222,240)
        Me.fraCliente.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.fraCliente.Controls.Add(Me._optCliente_0)
        Me.fraCliente.Controls.Add(Me._optCliente_1)
        Me.fraCliente.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.17!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fraCliente.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.fraCliente, "")
        Me.fraCliente.Location = New System.Drawing.Point(3, 3)
        Me.fraCliente.Name = "fraCliente"
        Me.COBISResourceProvider.SetResourceID(Me.fraCliente, "")
        Me.fraCliente.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraCliente.Size = New System.Drawing.Size(231, 35)
        Me.fraCliente.TabIndex = 16
        Me.fraCliente.TabStop = False
        Me.fraCliente.Text = "Tipo de Cliente"
        Me.fraCliente.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        '_optCliente_0
        '
        Me._optCliente_0.BackColor = System.Drawing.Color.Transparent
        Me._optCliente_0.Checked = True
        Me._optCliente_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCliente_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCliente_0.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me._optCliente_0, "")
        Me._optCliente_0.Location = New System.Drawing.Point(136, 14)
        Me._optCliente_0.Name = "_optCliente_0"
        Me.COBISResourceProvider.SetResourceID(Me._optCliente_0, "")
        Me._optCliente_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCliente_0.Size = New System.Drawing.Size(88, 15)
        Me._optCliente_0.TabIndex = 1
        Me._optCliente_0.TabStop = True
        Me._optCliente_0.Text = "P. &Natural"
        Me._optCliente_0.UseVisualStyleBackColor = True
        '
        '_optCliente_1
        '
        Me._optCliente_1.BackColor = System.Drawing.Color.Transparent
        Me._optCliente_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCliente_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold)
        Me._optCliente_1.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me._optCliente_1, "")
        Me._optCliente_1.Location = New System.Drawing.Point(16, 14)
        Me._optCliente_1.Name = "_optCliente_1"
        Me.COBISResourceProvider.SetResourceID(Me._optCliente_1, "")
        Me._optCliente_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCliente_1.Size = New System.Drawing.Size(112, 17)
        Me._optCliente_1.TabIndex = 0
        Me._optCliente_1.TabStop = True
        Me._optCliente_1.Text = "P.  Jurídica"
        Me._optCliente_1.UseVisualStyleBackColor = True
        '
        'fraCriterio
        '
        Me.fraCriterio.BackColor = System.Drawing.Color.FromArgb(205,222,240)
        Me.fraCriterio.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.fraCriterio.Controls.Add(Me._optCriterio_3)
        Me.fraCriterio.Controls.Add(Me._optCriterio_1)
        Me.fraCriterio.Controls.Add(Me._optCriterio_0)
        Me.fraCriterio.Controls.Add(Me._optCriterio_2)
        Me.fraCriterio.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fraCriterio.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.fraCriterio, "")
        Me.fraCriterio.Location = New System.Drawing.Point(3, 77)
        Me.fraCriterio.Name = "fraCriterio"
        Me.COBISResourceProvider.SetResourceID(Me.fraCriterio, "")
        Me.fraCriterio.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraCriterio.Size = New System.Drawing.Size(585, 45)
        Me.fraCriterio.TabIndex = 15
        Me.fraCriterio.TabStop = False
        Me.fraCriterio.Text = "Criterios de Búsqueda"
        Me.fraCriterio.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        '_optCriterio_3
        '
        Me._optCriterio_3.BackColor = System.Drawing.Color.Transparent
        Me._optCriterio_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCriterio_3.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me._optCriterio_3, "")
        Me._optCriterio_3.Location = New System.Drawing.Point(15, 19)
        Me._optCriterio_3.Name = "_optCriterio_3"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_3, "")
        Me._optCriterio_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_3.Size = New System.Drawing.Size(85, 15)
        Me._optCriterio_3.TabIndex = 5
        Me._optCriterio_3.TabStop = True
        Me._optCriterio_3.Text = "&Alfabético"
        Me._optCriterio_3.UseVisualStyleBackColor = True
        '
        '_optCriterio_1
        '
        Me._optCriterio_1.BackColor = System.Drawing.Color.Transparent
        Me._optCriterio_1.Checked = True
        Me._optCriterio_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCriterio_1.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me._optCriterio_1, "")
        Me._optCriterio_1.Location = New System.Drawing.Point(136, 19)
        Me._optCriterio_1.Name = "_optCriterio_1"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_1, "")
        Me._optCriterio_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_1.Size = New System.Drawing.Size(113, 15)
        Me._optCriterio_1.TabIndex = 6
        Me._optCriterio_1.TabStop = True
        Me._optCriterio_1.Text = "Número de &D.I."
        Me._optCriterio_1.UseVisualStyleBackColor = True
        '
        '_optCriterio_0
        '
        Me._optCriterio_0.BackColor = System.Drawing.Color.Transparent
        Me._optCriterio_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCriterio_0.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me._optCriterio_0, "")
        Me._optCriterio_0.Location = New System.Drawing.Point(261, 17)
        Me._optCriterio_0.Name = "_optCriterio_0"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_0, "")
        Me._optCriterio_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_0.Size = New System.Drawing.Size(129, 15)
        Me._optCriterio_0.TabIndex = 7
        Me._optCriterio_0.Text = "&Consecutivo Cliente"
        Me._optCriterio_0.UseVisualStyleBackColor = True
        '
        '_optCriterio_2
        '
        Me._optCriterio_2.BackColor = System.Drawing.Color.Transparent
        Me._optCriterio_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_2.Enabled = False
        Me._optCriterio_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCriterio_2.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.COBISResourceProvider.SetImageID(Me._optCriterio_2, "")
        Me._optCriterio_2.Location = New System.Drawing.Point(536, 134)
        Me._optCriterio_2.Name = "_optCriterio_2"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_2, "")
        Me._optCriterio_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_2.Size = New System.Drawing.Size(37, 15)
        Me._optCriterio_2.TabIndex = 14
        Me._optCriterio_2.Text = "Pasapo&rte"
        Me._optCriterio_2.UseVisualStyleBackColor = True
        Me._optCriterio_2.Visible = False
        '
        '_lblEtiqueta_2
        '
        Me._lblEtiqueta_2.BackColor = System.Drawing.SystemColors.Control
        Me._lblEtiqueta_2.FloodColor = System.Drawing.Color.Empty
        Me._lblEtiqueta_2.FloodPercent = CType(0, Short)
        Me.COBISResourceProvider.SetImageID(Me._lblEtiqueta_2, "")
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(145, 176)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "")
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(47, 15)
        Me._lblEtiqueta_2.TabIndex = 19
        Me._lblEtiqueta_2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me._lblEtiqueta_2.Visible = False
        '
        'txtOficinaOpt
        '
        Me.txtOficinaOpt.AcceptsReturn = True
        Me.txtOficinaOpt.BackColor = System.Drawing.SystemColors.Window
        Me.txtOficinaOpt.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.txtOficinaOpt.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtOficinaOpt.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtOficinaOpt.ForeColor = System.Drawing.SystemColors.WindowText
        Me.COBISResourceProvider.SetImageID(Me.txtOficinaOpt, "")
        Me.txtOficinaOpt.Location = New System.Drawing.Point(189, 175)
        Me.txtOficinaOpt.MaxLength = 4
        Me.txtOficinaOpt.Name = "txtOficinaOpt"
        Me.COBISResourceProvider.SetResourceID(Me.txtOficinaOpt, "")
        Me.txtOficinaOpt.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtOficinaOpt.Size = New System.Drawing.Size(50, 20)
        Me.txtOficinaOpt.TabIndex = 20
        Me.txtOficinaOpt.Visible = False
        '
        'fraAlianza
        '
        Me.fraAlianza.BackColor = System.Drawing.Color.FromArgb(205,222,240)
        Me.fraAlianza.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.fraAlianza.Controls.Add(Me.txtAlianza)
        Me.fraAlianza.Controls.Add(Me._lblEtiqueta_1)
        Me.fraAlianza.Controls.Add(Me.lblAlianza)
        Me.fraAlianza.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fraAlianza.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.fraAlianza, "")
        Me.fraAlianza.Location = New System.Drawing.Point(3, 40)
        Me.fraAlianza.Name = "fraAlianza"
        Me.COBISResourceProvider.SetResourceID(Me.fraAlianza, "")
        Me.fraAlianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraAlianza.Size = New System.Drawing.Size(585, 35)
        Me.fraAlianza.TabIndex = 25
        Me.fraAlianza.TabStop = False
        Me.fraAlianza.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        'txtAlianza
        '
        Me.txtAlianza.AcceptsReturn = True
        Me.txtAlianza.BackColor = System.Drawing.SystemColors.Window
        Me.txtAlianza.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.txtAlianza.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtAlianza.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtAlianza.ForeColor = System.Drawing.SystemColors.WindowText
        Me.COBISResourceProvider.SetImageID(Me.txtAlianza, "")
        Me.txtAlianza.Location = New System.Drawing.Point(119, 11)
        Me.txtAlianza.MaxLength = 4
        Me.txtAlianza.Name = "txtAlianza"
        Me.COBISResourceProvider.SetResourceID(Me.txtAlianza, "")
        Me.txtAlianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtAlianza.Size = New System.Drawing.Size(112, 20)
        Me.txtAlianza.TabIndex = 26
        '
        '_lblEtiqueta_1
        '
        Me._lblEtiqueta_1.BackColor = System.Drawing.SystemColors.Control
        Me._lblEtiqueta_1.FloodColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._lblEtiqueta_1.FloodPercent = CType(0, Short)
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me._lblEtiqueta_1, "")
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(8, 11)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "")
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(120, 20)
        Me._lblEtiqueta_1.TabIndex = 27
        Me._lblEtiqueta_1.Text = "Alianza Comercial:"
        Me._lblEtiqueta_1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblAlianza
        '
        Me.lblAlianza.BackColor = System.Drawing.SystemColors.Control
        Me.lblAlianza.FloodColor = System.Drawing.Color.Empty
        Me.lblAlianza.FloodPercent = CType(0, Short)
        Me.COBISResourceProvider.SetImageID(Me.lblAlianza, "")
        Me.lblAlianza.Location = New System.Drawing.Point(237, 11)
        Me.lblAlianza.Name = "lblAlianza"
        Me.COBISResourceProvider.SetResourceID(Me.lblAlianza, "")
        Me.lblAlianza.Size = New System.Drawing.Size(340, 19)
        Me.lblAlianza.TabIndex = 28
        Me.lblAlianza.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblDesOficina
        '
        Me.lblDesOficina.BackColor = System.Drawing.Color.FromArgb(233,236,240)
        Me.lblDesOficina.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.lblDesOficina.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISResourceProvider.SetImageID(Me.lblDesOficina, "")
        Me.lblDesOficina.Location = New System.Drawing.Point(240, 175)
        Me.lblDesOficina.Name = "lblDesOficina"
        Me.COBISResourceProvider.SetResourceID(Me.lblDesOficina, "")
        Me.lblDesOficina.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDesOficina.Size = New System.Drawing.Size(43, 19)
        Me.lblDesOficina.TabIndex = 21
        Me.lblDesOficina.Visible = False
        '
        'il_titulo02
        '
        Me.il_titulo02.BackColor = System.Drawing.Color.FromArgb(233,236,240)
        Me.il_titulo02.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.il_titulo02.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISResourceProvider.SetImageID(Me.il_titulo02, "")
        Me.il_titulo02.Location = New System.Drawing.Point(1, 561)
        Me.il_titulo02.Name = "il_titulo02"
        Me.COBISResourceProvider.SetResourceID(Me.il_titulo02, "")
        Me.il_titulo02.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.il_titulo02.Size = New System.Drawing.Size(628, 17)
        Me.il_titulo02.TabIndex = 17
        Me.il_titulo02.Visible = False
        '
        'commandButtonHelper1
        '
        Me.COBISResourceProvider.SetImageID(Me.commandButtonHelper1, "")
        Me.COBISResourceProvider.SetResourceID(Me.commandButtonHelper1, "")
        '
        'TSBotones
        '
        Me.COBISResourceProvider.SetImageID(Me.TSBotones, "")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBEscoger, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.COBISResourceProvider.SetResourceID(Me.TSBotones, "")
        Me.TSBotones.Size = New System.Drawing.Size(601, 25)
        Me.TSBotones.TabIndex = 26
        Me.TSBotones.Text = "ToolStrip1"
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "")
        Me.TSBBuscar.Size = New System.Drawing.Size(65, 22)
        Me.TSBBuscar.Text = "*Buscar"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "")
        Me.TSBSiguiente.Size = New System.Drawing.Size(77, 22)
        Me.TSBSiguiente.Text = "*Siguiente"
        '
        'TSBEscoger
        '
        Me.TSBEscoger.ForeColor = System.Drawing.Color.Black
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "")
        Me.TSBEscoger.Size = New System.Drawing.Size(71, 22)
        Me.TSBEscoger.Text = "*Escoger"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "")
        Me.TSBSalir.Size = New System.Drawing.Size(53, 22)
        Me.TSBSalir.Text = "*Salir"
        '
        'PForma
        '
        Me.PForma.Controls.Add(Me.fraCliente)
        Me.PForma.Controls.Add(Me._lblEtiqueta_0)
        Me.PForma.Controls.Add(Me.Frame3D1)
        Me.PForma.Controls.Add(Me.fraAlianza)
        Me.PForma.Controls.Add(Me.fraCriterio)
        Me.PForma.Controls.Add(Me.grdResultados)
        Me.COBISResourceProvider.SetImageID(Me.PForma, "")
        Me.PForma.Location = New System.Drawing.Point(10, 35)
        Me.PForma.Name = "PForma"
        Me.COBISResourceProvider.SetResourceID(Me.PForma, "")
        Me.PForma.Size = New System.Drawing.Size(591, 361)
        Me.PForma.TabIndex = 27
        Me.PForma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        'FBuscarCliente
        '
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.ClientSize = New System.Drawing.Size(601, 399)
        Me.Controls.Add(Me.Pforma)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Silver
        Me.COBISResourceProvider.SetImageID(Me, "")
        Me.Location = New System.Drawing.Point(38, 129)
        Me.Name = "FBuscarCliente"
        Me.COBISResourceProvider.SetResourceID(Me, "")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Tag = "1318"
        Me.Text = "Búsqueda de Clientes y Prospectos"
        Me.Frame3D1.ResumeLayout(False)
        CType(Me.grdResultados, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraCliente.ResumeLayout(False)
        Me.fraCriterio.ResumeLayout(False)
        Me.fraAlianza.ResumeLayout(False)
        Me.fraAlianza.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        Me.PForma.ResumeLayout(False)
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Pforma.ResumeLayout(False)
        Me.Pforma.PerformLayout()
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
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
    End Sub
    Sub InitializecmdBuscar()
        Me.cmdBuscar(1) = _cmdBuscar_1
        Me.cmdBuscar(0) = _cmdBuscar_0
    End Sub
    Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents PForma As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


