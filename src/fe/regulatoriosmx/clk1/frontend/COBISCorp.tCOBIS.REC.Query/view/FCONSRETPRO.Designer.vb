Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FCONSRETPROClass
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
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
    Public WithEvents txtCliente As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Public WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Public WithEvents fraCriterio As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents grdResultado As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Public cmdBoton(5) As System.Windows.Forms.Button
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FCONSRETPROClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.fraCriterio = New Infragistics.Win.Misc.UltraGroupBox()
        Me.mskFechaDesde = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._il_mascara_1 = New System.Windows.Forms.Label()
        Me._il_mascara_5 = New System.Windows.Forms.Label()
        Me.mskFechaHasta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.lblCliente = New System.Windows.Forms.Label()
        Me.lblAplicativo = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.txtProducto = New System.Windows.Forms.TextBox()
        Me.txtCliente = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me.grdResultado = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GBCuentas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.TSBExcel = New System.Windows.Forms.ToolStripButton()
        CType(Me.fraCriterio, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraCriterio.SuspendLayout()
        CType(Me.grdResultado, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GBCuentas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GBCuentas.SuspendLayout()
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
        'fraCriterio
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraCriterio, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraCriterio, False)
        Me.fraCriterio.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraCriterio.Controls.Add(Me.mskFechaDesde)
        Me.fraCriterio.Controls.Add(Me._il_mascara_1)
        Me.fraCriterio.Controls.Add(Me._il_mascara_5)
        Me.fraCriterio.Controls.Add(Me.mskFechaHasta)
        Me.fraCriterio.Controls.Add(Me.lblCliente)
        Me.fraCriterio.Controls.Add(Me.lblAplicativo)
        Me.fraCriterio.Controls.Add(Me._lblEtiqueta_0)
        Me.fraCriterio.Controls.Add(Me.txtProducto)
        Me.fraCriterio.Controls.Add(Me.txtCliente)
        Me.fraCriterio.Controls.Add(Me._lblEtiqueta_2)
        Me.COBISStyleProvider.SetControlStyle(Me.fraCriterio, "Default")
        Me.fraCriterio.ForeColor = System.Drawing.Color.Navy
        Me.fraCriterio.Location = New System.Drawing.Point(10, 10)
        Me.fraCriterio.Name = "fraCriterio"
        Me.COBISResourceProvider.SetResourceID(Me.fraCriterio, "5089")
        Me.fraCriterio.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraCriterio.Size = New System.Drawing.Size(553, 109)
        Me.fraCriterio.TabIndex = 0
        Me.fraCriterio.Text = "*Criterios de B�squeda"
        Me.fraCriterio.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraCriterio, "")
        '
        'mskFechaDesde
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskFechaDesde, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskFechaDesde, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskFechaDesde, "Default")
        Me.mskFechaDesde.Length = CType(64, Short)
        Me.mskFechaDesde.Location = New System.Drawing.Point(104, 30)
        Me.mskFechaDesde.Mask = "##/##/####"
        Me.mskFechaDesde.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.mskFechaDesde.MaxReal = 3.402823E+38!
        Me.mskFechaDesde.MinReal = -3.402823E+38!
        Me.mskFechaDesde.Name = "mskFechaDesde"
        Me.mskFechaDesde.Size = New System.Drawing.Size(89, 20)
        Me.mskFechaDesde.TabIndex = 0
        Me.mskFechaDesde.ValidatingType = GetType(Date)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskFechaDesde, "")
        '
        '_il_mascara_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_1, False)
        Me._il_mascara_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_1, "Default")
        Me._il_mascara_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_1.ForeColor = System.Drawing.Color.Navy
        Me._il_mascara_1.Location = New System.Drawing.Point(10, 30)
        Me._il_mascara_1.Name = "_il_mascara_1"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_1, "5172")
        Me._il_mascara_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_1.Size = New System.Drawing.Size(83, 20)
        Me._il_mascara_1.TabIndex = 21
        Me._il_mascara_1.Text = "*Fecha desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_1, "")
        '
        '_il_mascara_5
        '
        Me._il_mascara_5.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_5, False)
        Me._il_mascara_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_5, "Default")
        Me._il_mascara_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_5.ForeColor = System.Drawing.Color.Navy
        Me._il_mascara_5.Location = New System.Drawing.Point(364, 30)
        Me._il_mascara_5.Name = "_il_mascara_5"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_5, "5173")
        Me._il_mascara_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_5.Size = New System.Drawing.Size(86, 20)
        Me._il_mascara_5.TabIndex = 22
        Me._il_mascara_5.Text = "*Fecha hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_5, "")
        '
        'mskFechaHasta
        '
        Me.mskFechaHasta.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.mskFechaHasta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskFechaHasta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskFechaHasta, "Default")
        Me.mskFechaHasta.Length = CType(64, Short)
        Me.mskFechaHasta.Location = New System.Drawing.Point(453, 30)
        Me.mskFechaHasta.Mask = "##/##/####"
        Me.mskFechaHasta.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.mskFechaHasta.MaxReal = 3.402823E+38!
        Me.mskFechaHasta.MinReal = -3.402823E+38!
        Me.mskFechaHasta.Name = "mskFechaHasta"
        Me.mskFechaHasta.Size = New System.Drawing.Size(89, 20)
        Me.mskFechaHasta.TabIndex = 1
        Me.mskFechaHasta.ValidatingType = GetType(Date)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskFechaHasta, "")
        '
        'lblCliente
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCliente, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCliente, False)
        Me.lblCliente.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblCliente.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblCliente, "Default")
        Me.lblCliente.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCliente.ForeColor = System.Drawing.Color.White
        Me.lblCliente.Location = New System.Drawing.Point(194, 53)
        Me.lblCliente.Name = "lblCliente"
        Me.lblCliente.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCliente.Size = New System.Drawing.Size(348, 20)
        Me.lblCliente.TabIndex = 16
        Me.lblCliente.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCliente, "")
        '
        'lblAplicativo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblAplicativo, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblAplicativo, False)
        Me.lblAplicativo.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblAplicativo.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblAplicativo, "Default")
        Me.lblAplicativo.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblAplicativo.ForeColor = System.Drawing.Color.White
        Me.lblAplicativo.Location = New System.Drawing.Point(194, 76)
        Me.lblAplicativo.Name = "lblAplicativo"
        Me.lblAplicativo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblAplicativo.Size = New System.Drawing.Size(348, 20)
        Me.lblAplicativo.TabIndex = 14
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblAplicativo, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 76)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "5048")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(83, 20)
        Me._lblEtiqueta_0.TabIndex = 15
        Me._lblEtiqueta_0.Text = "*Producto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'txtProducto
        '
        Me.txtProducto.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtProducto, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtProducto, False)
        Me.txtProducto.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtProducto, "Default")
        Me.txtProducto.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtProducto.Location = New System.Drawing.Point(104, 76)
        Me.txtProducto.MaxLength = 5
        Me.txtProducto.Name = "txtProducto"
        Me.txtProducto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtProducto.Size = New System.Drawing.Size(89, 20)
        Me.txtProducto.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtProducto, "")
        '
        'txtCliente
        '
        Me.txtCliente.AsociatedLabelIndex = CType(742, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCliente, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCliente, False)
        Me.txtCliente.BackColor = System.Drawing.SystemColors.Control
        Me.txtCliente.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.txtCliente, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me.txtCliente, True)
        Me.txtCliente.Error = CType(0, Short)
        Me.txtCliente.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCliente.HelpLine = Nothing
        Me.txtCliente.Location = New System.Drawing.Point(104, 53)
        Me.txtCliente.MaxLength = CType(0, Short)
        Me.txtCliente.MinChar = CType(0, Short)
        Me.txtCliente.Name = "txtCliente"
        Me.txtCliente.Pendiente = Nothing
        Me.txtCliente.Range = Nothing
        Me.txtCliente.Size = New System.Drawing.Size(89, 20)
        Me.txtCliente.TabIndex = 2
        Me.txtCliente.TableName = Nothing
        Me.txtCliente.TitleCatalog = Nothing
        Me.txtCliente.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Int
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCliente, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 53)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "500163")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(83, 20)
        Me._lblEtiqueta_2.TabIndex = 8
        Me._lblEtiqueta_2.Text = "*Cliente:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        'grdResultado
        '
        Me.grdResultado._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdResultado, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdResultado, False)
        Me.grdResultado.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdResultado.Clip = ""
        Me.grdResultado.Col = CType(1, Short)
        Me.grdResultado.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdResultado.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdResultado.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdResultado, "Default")
        Me.grdResultado.CtlText = ""
        Me.grdResultado.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdResultado, True)
        Me.grdResultado.FixedCols = CType(1, Short)
        Me.grdResultado.FixedRows = CType(1, Short)
        Me.grdResultado.ForeColor = System.Drawing.Color.Black
        Me.grdResultado.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdResultado.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdResultado.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdResultado.HighLight = True
        Me.grdResultado.Location = New System.Drawing.Point(3, 0)
        Me.grdResultado.Name = "grdResultado"
        Me.grdResultado.Picture = Nothing
        Me.grdResultado.Row = CType(1, Short)
        Me.grdResultado.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdResultado.Size = New System.Drawing.Size(547, 222)
        Me.grdResultado.Sort = CType(2, Short)
        Me.grdResultado.TabIndex = 4
        Me.grdResultado.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdResultado, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-559, 1)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(65, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 2
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "&Buscar"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-560, 303)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(65, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 4
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "&Salir"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        '_cmdBoton_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_5, False)
        Me._cmdBoton_5.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_5, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_5, True)
        Me._cmdBoton_5.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_5, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_5, Nothing)
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Location = New System.Drawing.Point(-560, 191)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(65, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 5
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "&Escoger"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-560, 247)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(65, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 6
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "&Limpiar"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GBCuentas)
        Me.PFormas.Controls.Add(Me.fraCriterio)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(573, 359)
        Me.PFormas.TabIndex = 13
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GBCuentas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GBCuentas, False)
        Me.COBISViewResizer.SetAutoResize(Me.GBCuentas, False)
        Me.GBCuentas.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GBCuentas.Controls.Add(Me.grdResultado)
        Me.COBISStyleProvider.SetControlStyle(Me.GBCuentas, "Default")
        Me.GBCuentas.ForeColor = System.Drawing.Color.Navy
        Me.GBCuentas.Location = New System.Drawing.Point(10, 125)
        Me.GBCuentas.Name = "GBCuentas"
        Me.GBCuentas.Size = New System.Drawing.Size(553, 225)
        Me.GBCuentas.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GBCuentas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBExcel, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(589, 25)
        Me.TSBotones.TabIndex = 14
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
        Me.TSBBuscar.Text = "*&Buscar"
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
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'TSBExcel
        '
        Me.TSBExcel.ForeColor = System.Drawing.Color.Black
        Me.TSBExcel.Image = CType(resources.GetObject("TSBExcel.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBExcel, "2500")
        Me.TSBExcel.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBExcel.Name = "TSBExcel"
        Me.COBISResourceProvider.SetResourceID(Me.TSBExcel, "2068")
        Me.TSBExcel.Size = New System.Drawing.Size(58, 22)
        Me.TSBExcel.Text = "*&Excel"
        '
        'FCONSRETPROClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._cmdBoton_5)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Silver
        Me.Location = New System.Drawing.Point(144, 181)
        Me.Name = "FCONSRETPROClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(589, 400)
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.fraCriterio, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraCriterio.ResumeLayout(False)
        Me.fraCriterio.PerformLayout()
        CType(Me.grdResultado, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.GBCuentas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GBCuentas.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(2) = _cmdBoton_2
    End Sub

    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GBCuentas As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents lblCliente As System.Windows.Forms.Label
    Private WithEvents lblAplicativo As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Public WithEvents txtProducto As System.Windows.Forms.TextBox
    Public WithEvents mskFechaDesde As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _il_mascara_1 As System.Windows.Forms.Label
    Private WithEvents _il_mascara_5 As System.Windows.Forms.Label
    Public WithEvents mskFechaHasta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Friend WithEvents TSBExcel As System.Windows.Forms.ToolStripButton
#End Region
End Class


