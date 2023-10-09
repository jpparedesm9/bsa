<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FCheqAprobRechazClass
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        InitializeComponent()
        InitializetxtCampo()
        InitializecmdBoton()
    End Sub
    Private Sub ReleaseResources(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Closed
        Dispose(True)
    End Sub
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
        If Disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(Disposing)
    End Sub
    Private components As System.ComponentModel.IContainer
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Public cmdBoton(6) As System.Windows.Forms.Button
    Public txtCampo(3) As System.Windows.Forms.TextBox
    Public linSeparador(2) As System.Windows.Forms.Label
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FCheqAprobRechazClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me.PForma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.lblDescripcion = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me.cmbBcoChq = New System.Windows.Forms.ComboBox()
        Me.lblBcoChq = New System.Windows.Forms.Label()
        Me.cmbTipoChq = New System.Windows.Forms.ComboBox()
        Me.lblTipoChq = New System.Windows.Forms.Label()
        Me.cmbEstado = New System.Windows.Forms.ComboBox()
        Me.lblEstado = New System.Windows.Forms.Label()
        Me.txtCheque = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.mmskFecha = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.lblFecha = New System.Windows.Forms.Label()
        Me.mskCuentaOperacion = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.lblCtaOperacion = New System.Windows.Forms.Label()
        Me.cmbTipoProducto = New System.Windows.Forms.ComboBox()
        Me.lblProducto = New System.Windows.Forms.Label()
        Me._lblCheque_1 = New System.Windows.Forms.Label()
        Me.frmReporte = New Infragistics.Win.Misc.UltraGroupBox()
        Me.grdAprobRechazCqh = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.cmdEfectivizar = New System.Windows.Forms.Button()
        Me.grdRegionales = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.lblRegional = New System.Windows.Forms.Label()
        Me._picVisto_0 = New System.Windows.Forms.PictureBox()
        Me._picVisto_1 = New System.Windows.Forms.PictureBox()
        Me.chkmarca = New System.Windows.Forms.CheckBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBDevolver = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.PForma, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PForma.SuspendLayout()
        CType(Me.frmReporte, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmReporte.SuspendLayout()
        CType(Me.grdAprobRechazCqh, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdRegionales, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).BeginInit()
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
        Me.COBISResourceProvider.SetImageID(Me._cmdBoton_2, "2003")
        Me._cmdBoton_2.Location = New System.Drawing.Point(-32768, -32768)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 8
        Me._cmdBoton_2.Text = "*&Limpiar"
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
        Me.COBISResourceProvider.SetImageID(Me._cmdBoton_0, "2000")
        Me._cmdBoton_0.Location = New System.Drawing.Point(-32768, -32768)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 1
        Me._cmdBoton_0.Text = "*&Buscar"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me.COBISResourceProvider.SetImageID(Me._cmdBoton_6, "2008")
        Me._cmdBoton_6.Location = New System.Drawing.Point(-32768, -32768)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 9
        Me._cmdBoton_6.Text = "*&Salir"
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
        '
        'PForma
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PForma, False)
        Me.COBISViewResizer.SetAutoResize(Me.PForma, False)
        Me.PForma.Controls.Add(Me.lblDescripcion)
        Me.PForma.Controls.Add(Me._lblEtiqueta_1)
        Me.PForma.Controls.Add(Me._txtCampo_0)
        Me.PForma.Controls.Add(Me.cmbBcoChq)
        Me.PForma.Controls.Add(Me.lblBcoChq)
        Me.PForma.Controls.Add(Me.cmbTipoChq)
        Me.PForma.Controls.Add(Me.lblTipoChq)
        Me.PForma.Controls.Add(Me.cmbEstado)
        Me.PForma.Controls.Add(Me.lblEstado)
        Me.PForma.Controls.Add(Me.txtCheque)
        Me.PForma.Controls.Add(Me.mmskFecha)
        Me.PForma.Controls.Add(Me.lblFecha)
        Me.PForma.Controls.Add(Me.mskCuentaOperacion)
        Me.PForma.Controls.Add(Me.lblCtaOperacion)
        Me.PForma.Controls.Add(Me.cmbTipoProducto)
        Me.PForma.Controls.Add(Me.lblProducto)
        Me.PForma.Controls.Add(Me._lblCheque_1)
        Me.PForma.Controls.Add(Me.frmReporte)
        Me.COBISStyleProvider.SetControlStyle(Me.PForma, "Default")
        Me.PForma.Location = New System.Drawing.Point(10, 36)
        Me.PForma.Name = "PForma"
        Me.PForma.Size = New System.Drawing.Size(722, 351)
        Me.PForma.TabIndex = 18
        Me.PForma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PForma, "")
        '
        'lblDescripcion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescripcion, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescripcion, False)
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescripcion, "Default")
        Me.lblDescripcion.Enabled = False
        Me.lblDescripcion.Length = CType(64, Short)
        Me.lblDescripcion.Location = New System.Drawing.Point(528, 78)
        Me.lblDescripcion.MaxReal = 3.402823E+38!
        Me.lblDescripcion.MinReal = -3.402823E+38!
        Me.lblDescripcion.Name = "lblDescripcion"
        Me.lblDescripcion.Size = New System.Drawing.Size(168, 20)
        Me.lblDescripcion.TabIndex = 286
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescripcion, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.AutoSize = True
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(365, 78)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "5155")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(51, 13)
        Me._lblEtiqueta_1.TabIndex = 285
        Me._lblEtiqueta_1.Text = "*Causa:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
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
        Me._txtCampo_0.Enabled = False
        Me._txtCampo_0.ForeColor = System.Drawing.Color.Black
        Me._txtCampo_0.Location = New System.Drawing.Point(489, 78)
        Me._txtCampo_0.MaxLength = 3
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(33, 20)
        Me._txtCampo_0.TabIndex = 284
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        'cmbBcoChq
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbBcoChq, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbBcoChq, False)
        Me.COBISStyleProvider.SetControlStyle(Me.cmbBcoChq, "Default")
        Me.cmbBcoChq.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbBcoChq.Enabled = False
        Me.cmbBcoChq.FormattingEnabled = True
        Me.cmbBcoChq.Location = New System.Drawing.Point(489, 55)
        Me.cmbBcoChq.Name = "cmbBcoChq"
        Me.cmbBcoChq.Size = New System.Drawing.Size(207, 21)
        Me.cmbBcoChq.TabIndex = 280
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbBcoChq, "")
        '
        'lblBcoChq
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblBcoChq, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblBcoChq, False)
        Me.lblBcoChq.AutoSize = True
        Me.lblBcoChq.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblBcoChq, "Default")
        Me.lblBcoChq.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblBcoChq.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblBcoChq.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.lblBcoChq, "5249")
        Me.lblBcoChq.Location = New System.Drawing.Point(365, 57)
        Me.lblBcoChq.Name = "lblBcoChq"
        Me.COBISResourceProvider.SetResourceID(Me.lblBcoChq, "502304")
        Me.lblBcoChq.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblBcoChq.Size = New System.Drawing.Size(93, 13)
        Me.lblBcoChq.TabIndex = 283
        Me.lblBcoChq.Text = "*Banco Origen:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblBcoChq, "")
        '
        'cmbTipoChq
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbTipoChq, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbTipoChq, False)
        Me.COBISStyleProvider.SetControlStyle(Me.cmbTipoChq, "Default")
        Me.cmbTipoChq.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbTipoChq.FormattingEnabled = True
        Me.cmbTipoChq.Location = New System.Drawing.Point(489, 32)
        Me.cmbTipoChq.Name = "cmbTipoChq"
        Me.cmbTipoChq.Size = New System.Drawing.Size(207, 21)
        Me.cmbTipoChq.TabIndex = 279
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbTipoChq, "")
        '
        'lblTipoChq
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblTipoChq, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblTipoChq, False)
        Me.lblTipoChq.AutoSize = True
        Me.lblTipoChq.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblTipoChq, "Default")
        Me.lblTipoChq.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTipoChq.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTipoChq.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.lblTipoChq, "5249")
        Me.lblTipoChq.Location = New System.Drawing.Point(365, 34)
        Me.lblTipoChq.Name = "lblTipoChq"
        Me.COBISResourceProvider.SetResourceID(Me.lblTipoChq, "5074")
        Me.lblTipoChq.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTipoChq.Size = New System.Drawing.Size(106, 13)
        Me.lblTipoChq.TabIndex = 282
        Me.lblTipoChq.Text = "*Tipo de Cheque:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblTipoChq, "")
        '
        'cmbEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbEstado, False)
        Me.COBISStyleProvider.SetControlStyle(Me.cmbEstado, "Default")
        Me.cmbEstado.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbEstado.FormattingEnabled = True
        Me.cmbEstado.Location = New System.Drawing.Point(489, 9)
        Me.cmbEstado.Name = "cmbEstado"
        Me.cmbEstado.Size = New System.Drawing.Size(207, 21)
        Me.cmbEstado.TabIndex = 278
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbEstado, "")
        '
        'lblEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblEstado, False)
        Me.lblEstado.AutoSize = True
        Me.lblEstado.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblEstado, "Default")
        Me.lblEstado.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEstado.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblEstado.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.lblEstado, "5249")
        Me.lblEstado.Location = New System.Drawing.Point(365, 10)
        Me.lblEstado.Name = "lblEstado"
        Me.COBISResourceProvider.SetResourceID(Me.lblEstado, "5067")
        Me.lblEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEstado.Size = New System.Drawing.Size(55, 13)
        Me.lblEstado.TabIndex = 281
        Me.lblEstado.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblEstado, "")
        '
        'txtCheque
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCheque, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCheque, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtCheque, "Default")
        Me.txtCheque.Length = CType(64, Short)
        Me.txtCheque.Location = New System.Drawing.Point(140, 55)
        Me.txtCheque.MaxReal = 3.402823E+38!
        Me.txtCheque.MinReal = -3.402823E+38!
        Me.txtCheque.Name = "txtCheque"
        Me.txtCheque.Size = New System.Drawing.Size(207, 20)
        Me.txtCheque.TabIndex = 275
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCheque, "")
        '
        'mmskFecha
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mmskFecha, False)
        Me.COBISViewResizer.SetAutoResize(Me.mmskFecha, False)
        Me.mmskFecha.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer))
        Me.mmskFecha.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mmskFecha.ClipText = ""
        Me.COBISStyleProvider.SetControlStyle(Me.mmskFecha, "Default")
        Me.mmskFecha.Cuantas = 0
        Me.mmskFecha.DateString = "____/__/__"
        Me.mmskFecha.DateSybase = Nothing
        Me.mmskFecha.DateType = COBISCorp.Framework.UI.Components.ENUM_DATETYPE.yyyy_mm_dd
        Me.mmskFecha.Decimals = CType(2, Short)
        Me.mmskFecha.Enabled = False
        Me.mmskFecha.Errores = CType(0, Short)
        Me.mmskFecha.Fin = 0
        Me.mmskFecha.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.mmskFecha.FormattedText = ""
        Me.mmskFecha.HelpLine = "Fecha valor de la negociación"
        Me.mmskFecha.HideSelection = False
        Me.mmskFecha.hWnd = 0
        Me.mmskFecha.Location = New System.Drawing.Point(141, 78)
        Me.mmskFecha.Mask = "####/##/##"
        Me.mmskFecha.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASKTYPE.[Date]
        Me.mmskFecha.MaxLength = 0
        Me.mmskFecha.MaxReal = 0.0!
        Me.mmskFecha.MinReal = 0.0!
        Me.mmskFecha.Name = "mmskFecha"
        Me.mmskFecha.Nullable = False
        Me.mmskFecha.Separator = True
        Me.mmskFecha.Size = New System.Drawing.Size(80, 20)
        Me.mmskFecha.StringIndex = CType(0, Short)
        Me.mmskFecha.TabIndex = 276
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mmskFecha, "")
        '
        'lblFecha
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblFecha, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblFecha, False)
        Me.lblFecha.AutoSize = True
        Me.lblFecha.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblFecha, "Default")
        Me.lblFecha.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFecha.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFecha.ForeColor = System.Drawing.Color.Navy
        Me.lblFecha.Location = New System.Drawing.Point(10, 80)
        Me.lblFecha.Name = "lblFecha"
        Me.COBISResourceProvider.SetResourceID(Me.lblFecha, "500348")
        Me.lblFecha.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFecha.Size = New System.Drawing.Size(51, 13)
        Me.lblFecha.TabIndex = 277
        Me.lblFecha.Text = "*Fecha:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblFecha, "")
        '
        'mskCuentaOperacion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuentaOperacion, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuentaOperacion, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuentaOperacion, "Default")
        Me.mskCuentaOperacion.Length = CType(64, Short)
        Me.mskCuentaOperacion.Location = New System.Drawing.Point(140, 34)
        Me.mskCuentaOperacion.MaxReal = 3.402823E+38!
        Me.mskCuentaOperacion.MinReal = -3.402823E+38!
        Me.mskCuentaOperacion.Name = "mskCuentaOperacion"
        Me.mskCuentaOperacion.Size = New System.Drawing.Size(207, 20)
        Me.mskCuentaOperacion.TabIndex = 274
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuentaOperacion, "")
        '
        'lblCtaOperacion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCtaOperacion, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCtaOperacion, False)
        Me.lblCtaOperacion.AutoSize = True
        Me.lblCtaOperacion.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblCtaOperacion, "Default")
        Me.lblCtaOperacion.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCtaOperacion.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblCtaOperacion.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.lblCtaOperacion, "5249")
        Me.lblCtaOperacion.Location = New System.Drawing.Point(10, 34)
        Me.lblCtaOperacion.Name = "lblCtaOperacion"
        Me.COBISResourceProvider.SetResourceID(Me.lblCtaOperacion, "508649")
        Me.lblCtaOperacion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCtaOperacion.Size = New System.Drawing.Size(114, 13)
        Me.lblCtaOperacion.TabIndex = 273
        Me.lblCtaOperacion.Text = "*Nro. de Cta/Oper:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCtaOperacion, "")
        '
        'cmbTipoProducto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbTipoProducto, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbTipoProducto, False)
        Me.COBISStyleProvider.SetControlStyle(Me.cmbTipoProducto, "Default")
        Me.cmbTipoProducto.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbTipoProducto.FormattingEnabled = True
        Me.cmbTipoProducto.Location = New System.Drawing.Point(140, 10)
        Me.cmbTipoProducto.Name = "cmbTipoProducto"
        Me.cmbTipoProducto.Size = New System.Drawing.Size(207, 21)
        Me.cmbTipoProducto.TabIndex = 271
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbTipoProducto, "")
        '
        'lblProducto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblProducto, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblProducto, False)
        Me.lblProducto.AutoSize = True
        Me.lblProducto.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblProducto, "Default")
        Me.lblProducto.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblProducto.ForeColor = System.Drawing.Color.Navy
        Me.lblProducto.Location = New System.Drawing.Point(10, 10)
        Me.lblProducto.Name = "lblProducto"
        Me.COBISResourceProvider.SetResourceID(Me.lblProducto, "5048")
        Me.lblProducto.Size = New System.Drawing.Size(67, 13)
        Me.lblProducto.TabIndex = 272
        Me.lblProducto.Text = "*Producto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblProducto, "")
        '
        '_lblCheque_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblCheque_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblCheque_1, False)
        Me._lblCheque_1.AutoSize = True
        Me._lblCheque_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblCheque_1, "Default")
        Me._lblCheque_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblCheque_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblCheque_1.ForeColor = System.Drawing.Color.Navy
        Me._lblCheque_1.Location = New System.Drawing.Point(10, 57)
        Me._lblCheque_1.Name = "_lblCheque_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblCheque_1, "508454")
        Me._lblCheque_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblCheque_1.Size = New System.Drawing.Size(59, 13)
        Me._lblCheque_1.TabIndex = 270
        Me._lblCheque_1.Text = "*Cheque:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblCheque_1, "")
        '
        'frmReporte
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmReporte, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmReporte, False)
        Me.frmReporte.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmReporte.Controls.Add(Me.grdAprobRechazCqh)
        Me.COBISStyleProvider.SetControlStyle(Me.frmReporte, "Default")
        Me.frmReporte.ForeColor = System.Drawing.Color.Navy
        Me.frmReporte.Location = New System.Drawing.Point(10, 111)
        Me.frmReporte.Name = "frmReporte"
        Me.frmReporte.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmReporte.Size = New System.Drawing.Size(705, 235)
        Me.frmReporte.TabIndex = 12
        Me.frmReporte.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmReporte, "")
        '
        'grdAprobRechazCqh
        '
        Me.grdAprobRechazCqh._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdAprobRechazCqh, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdAprobRechazCqh, False)
        Me.grdAprobRechazCqh.BackgroundColor = System.Drawing.SystemColors.Control
        Me.grdAprobRechazCqh.Clip = ""
        Me.grdAprobRechazCqh.Col = CType(1, Short)
        Me.grdAprobRechazCqh.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdAprobRechazCqh.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdAprobRechazCqh.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdAprobRechazCqh, "Default")
        Me.grdAprobRechazCqh.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdAprobRechazCqh, True)
        Me.grdAprobRechazCqh.FixedCols = CType(1, Short)
        Me.grdAprobRechazCqh.FixedRows = CType(1, Short)
        Me.grdAprobRechazCqh.ForeColor = System.Drawing.Color.Black
        Me.grdAprobRechazCqh.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdAprobRechazCqh.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdAprobRechazCqh.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdAprobRechazCqh.HighLight = True
        Me.grdAprobRechazCqh.Location = New System.Drawing.Point(10, 10)
        Me.grdAprobRechazCqh.Name = "grdAprobRechazCqh"
        Me.grdAprobRechazCqh.Picture = Nothing
        Me.grdAprobRechazCqh.Row = CType(1, Short)
        Me.grdAprobRechazCqh.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdAprobRechazCqh.Size = New System.Drawing.Size(686, 213)
        Me.grdAprobRechazCqh.Sort = CType(2, Short)
        Me.grdAprobRechazCqh.TabIndex = 12
        Me.grdAprobRechazCqh.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdAprobRechazCqh, "")
        '
        'cmdEfectivizar
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdEfectivizar, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdEfectivizar, False)
        Me.cmdEfectivizar.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdEfectivizar, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdEfectivizar, True)
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdEfectivizar, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdEfectivizar, Nothing)
        Me.cmdEfectivizar.Enabled = False
        Me.cmdEfectivizar.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold)
        Me.cmdEfectivizar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdEfectivizar.Location = New System.Drawing.Point(317, 110)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdEfectivizar, System.Drawing.Color.Silver)
        Me.cmdEfectivizar.Name = "cmdEfectivizar"
        Me.cmdEfectivizar.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdEfectivizar.Size = New System.Drawing.Size(89, 20)
        Me.commandButtonHelper1.SetStyle(Me.cmdEfectivizar, 0)
        Me.cmdEfectivizar.TabIndex = 260
        Me.cmdEfectivizar.Tag = "2884"
        Me.cmdEfectivizar.Text = "&Devolver"
        Me.cmdEfectivizar.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdEfectivizar.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdEfectivizar, "")
        '
        'grdRegionales
        '
        Me.grdRegionales._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRegionales, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRegionales, False)
        Me.grdRegionales.BackgroundColor = System.Drawing.SystemColors.Control
        Me.grdRegionales.Clip = ""
        Me.grdRegionales.Col = CType(1, Short)
        Me.grdRegionales.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdRegionales.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdRegionales.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdRegionales, "Default")
        Me.grdRegionales.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdRegionales, True)
        Me.grdRegionales.FixedCols = CType(1, Short)
        Me.grdRegionales.FixedRows = CType(1, Short)
        Me.grdRegionales.ForeColor = System.Drawing.Color.Black
        Me.grdRegionales.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdRegionales.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdRegionales.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRegionales.HighLight = True
        Me.grdRegionales.Location = New System.Drawing.Point(73, 97)
        Me.grdRegionales.Name = "grdRegionales"
        Me.grdRegionales.Picture = Nothing
        Me.grdRegionales.Row = CType(1, Short)
        Me.grdRegionales.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegionales.Size = New System.Drawing.Size(207, 68)
        Me.grdRegionales.Sort = CType(2, Short)
        Me.grdRegionales.TabIndex = 239
        Me.grdRegionales.TopRow = CType(1, Short)
        Me.grdRegionales.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegionales, "")
        '
        'lblRegional
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblRegional, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblRegional, False)
        Me.lblRegional.AutoSize = True
        Me.lblRegional.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblRegional, "Default")
        Me.lblRegional.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblRegional.ForeColor = System.Drawing.Color.Navy
        Me.lblRegional.Location = New System.Drawing.Point(-72, 93)
        Me.lblRegional.Name = "lblRegional"
        Me.COBISResourceProvider.SetResourceID(Me.lblRegional, "505010")
        Me.lblRegional.Size = New System.Drawing.Size(66, 13)
        Me.lblRegional.TabIndex = 238
        Me.lblRegional.Text = "*Regional:"
        Me.lblRegional.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblRegional, "")
        '
        '_picVisto_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_0, False)
        Me._picVisto_0.BackColor = System.Drawing.Color.Gray
        Me._picVisto_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_0, "Default")
        Me._picVisto_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_0.Image = CType(resources.GetObject("_picVisto_0.Image"), System.Drawing.Image)
        Me._picVisto_0.Location = New System.Drawing.Point(168, 73)
        Me._picVisto_0.Name = "_picVisto_0"
        Me._picVisto_0.Size = New System.Drawing.Size(16, 17)
        Me._picVisto_0.TabIndex = 237
        Me._picVisto_0.TabStop = False
        Me._picVisto_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_0, "")
        '
        '_picVisto_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_1, False)
        Me._picVisto_1.BackColor = System.Drawing.Color.Silver
        Me._picVisto_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_1, "Default")
        Me._picVisto_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_1.Image = CType(resources.GetObject("_picVisto_1.Image"), System.Drawing.Image)
        Me._picVisto_1.Location = New System.Drawing.Point(185, 73)
        Me._picVisto_1.Name = "_picVisto_1"
        Me._picVisto_1.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_1.TabIndex = 236
        Me._picVisto_1.TabStop = False
        Me._picVisto_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_1, "")
        '
        'chkmarca
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkmarca, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkmarca, False)
        Me.chkmarca.AutoSize = True
        Me.chkmarca.BackColor = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.COBISStyleProvider.SetControlStyle(Me.chkmarca, "Default")
        Me.chkmarca.Enabled = False
        Me.chkmarca.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkmarca.ForeColor = System.Drawing.Color.Navy
        Me.chkmarca.Location = New System.Drawing.Point(73, 73)
        Me.chkmarca.Name = "chkmarca"
        Me.COBISResourceProvider.SetResourceID(Me.chkmarca, "505020")
        Me.chkmarca.Size = New System.Drawing.Size(109, 17)
        Me.chkmarca.TabIndex = 235
        Me.chkmarca.Text = "*Marcar Todos"
        Me.chkmarca.UseVisualStyleBackColor = True
        Me.chkmarca.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkmarca, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.TSBotones.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBDevolver, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(736, 25)
        Me.TSBotones.TabIndex = 71
        Me.TSBotones.TabStop = True
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
        Me.TSBBuscar.Text = "*Buscar"
        '
        'TSBDevolver
        '
        Me.TSBDevolver.Enabled = False
        Me.TSBDevolver.ForeColor = System.Drawing.Color.Black
        Me.TSBDevolver.Image = CType(resources.GetObject("TSBDevolver.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBDevolver, "2062")
        Me.TSBDevolver.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBDevolver.Name = "TSBDevolver"
        Me.COBISResourceProvider.SetResourceID(Me.TSBDevolver, "2022")
        Me.TSBDevolver.Size = New System.Drawing.Size(78, 22)
        Me.TSBDevolver.Text = "*Devolver"
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
        Me.TSBLimpiar.Text = "*Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*Salir"
        '
        'FCheqAprobRechazClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PForma)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me.cmdEfectivizar)
        Me.Controls.Add(Me.grdRegionales)
        Me.Controls.Add(Me.lblRegional)
        Me.Controls.Add(Me._picVisto_0)
        Me.Controls.Add(Me._picVisto_1)
        Me.Controls.Add(Me.chkmarca)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(3, 29)
        Me.Name = "FCheqAprobRechazClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(736, 390)
        Me.Tag = "3880"
        Me.Text = "*Registro de Cheques Aprobados y Rechazados"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.PForma, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PForma.ResumeLayout(False)
        Me.PForma.PerformLayout()
        CType(Me.frmReporte, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmReporte.ResumeLayout(False)
        CType(Me.grdAprobRechazCqh, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdRegionales, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Sub InitializetxtCampo()
        Me.txtCampo(0) = _txtCampo_0
    End Sub

    Sub InitializecmdBoton()
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = cmdEfectivizar
        Me.cmdBoton(6) = _cmdBoton_6
    End Sub
    Friend WithEvents PForma As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents frmReporte As Infragistics.Win.Misc.UltraGroupBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    Friend WithEvents grdAprobRechazCqh As COBISCorp.Framework.UI.Components.COBISGrid
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents grdRegionales As COBISCorp.Framework.UI.Components.COBISGrid
    Friend WithEvents lblRegional As System.Windows.Forms.Label
    Private WithEvents _picVisto_0 As System.Windows.Forms.PictureBox
    Private WithEvents _picVisto_1 As System.Windows.Forms.PictureBox
    Friend WithEvents chkmarca As System.Windows.Forms.CheckBox
    Private WithEvents cmdEfectivizar As System.Windows.Forms.Button
    Friend WithEvents TSBDevolver As System.Windows.Forms.ToolStripButton
    Public WithEvents lblDescripcion As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Friend WithEvents cmbBcoChq As System.Windows.Forms.ComboBox
    Private WithEvents lblBcoChq As System.Windows.Forms.Label
    Friend WithEvents cmbTipoChq As System.Windows.Forms.ComboBox
    Private WithEvents lblTipoChq As System.Windows.Forms.Label
    Friend WithEvents cmbEstado As System.Windows.Forms.ComboBox
    Private WithEvents lblEstado As System.Windows.Forms.Label
    Public WithEvents txtCheque As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents mmskFecha As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Private WithEvents lblFecha As System.Windows.Forms.Label
    Public WithEvents mskCuentaOperacion As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents lblCtaOperacion As System.Windows.Forms.Label
    Friend WithEvents cmbTipoProducto As System.Windows.Forms.ComboBox
    Friend WithEvents lblProducto As System.Windows.Forms.Label
    Private WithEvents _lblCheque_1 As System.Windows.Forms.Label
#End Region
End Class