<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FBuscarGrupoClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializeoptCriterio()
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
    Public WithEvents txtValor As System.Windows.Forms.TextBox
    Private WithEvents _optCriterio_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optCriterio_1 As System.Windows.Forms.RadioButton
    Public WithEvents fraCriterio As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents cmdSalir As System.Windows.Forms.Button
    Public WithEvents cmdEscoger As System.Windows.Forms.Button
    Private WithEvents _cmdBuscar_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBuscar_0 As System.Windows.Forms.Button
    Public WithEvents grdResultados As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents lblEtiqueta As System.Windows.Forms.Label
    Public cmdBuscar(1) As System.Windows.Forms.Button
    Public optCriterio(1) As System.Windows.Forms.RadioButton
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FBuscarGrupoClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.txtValor = New System.Windows.Forms.TextBox()
        Me.fraCriterio = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optCriterio_0 = New System.Windows.Forms.RadioButton()
        Me._optCriterio_1 = New System.Windows.Forms.RadioButton()
        Me.cmdSalir = New System.Windows.Forms.Button()
        Me.cmdEscoger = New System.Windows.Forms.Button()
        Me._cmdBuscar_1 = New System.Windows.Forms.Button()
        Me._cmdBuscar_0 = New System.Windows.Forms.Button()
        Me.grdResultados = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.lblEtiqueta = New System.Windows.Forms.Label()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.fraCriterio, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraCriterio.SuspendLayout()
        CType(Me.grdResultados, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TSBotones.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        '
        'txtValor
        '
        Me.txtValor.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtValor, False)
        Me.txtValor.BackColor = System.Drawing.SystemColors.Window
        Me.txtValor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.txtValor, "Default")
        Me.txtValor.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtValor.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtValor.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtValor.Location = New System.Drawing.Point(131, 73)
        Me.txtValor.MaxLength = 0
        Me.txtValor.Name = "txtValor"
        Me.txtValor.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtValor.Size = New System.Drawing.Size(339, 20)
        Me.txtValor.TabIndex = 2
        Me.txtValor.Tag = "3"
        Me.txtValor.Text = "%"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtValor, "")
        '
        'fraCriterio
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraCriterio, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraCriterio, False)
        Me.fraCriterio.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraCriterio.Controls.Add(Me._optCriterio_0)
        Me.fraCriterio.Controls.Add(Me._optCriterio_1)
        Me.COBISStyleProvider.SetControlStyle(Me.fraCriterio, "Default")
        Me.fraCriterio.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fraCriterio.ForeColor = System.Drawing.Color.Navy
        Me.fraCriterio.Location = New System.Drawing.Point(10, 10)
        Me.fraCriterio.Name = "fraCriterio"
        Me.COBISResourceProvider.SetResourceID(Me.fraCriterio, "1128")
        Me.fraCriterio.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraCriterio.Size = New System.Drawing.Size(460, 57)
        Me.fraCriterio.TabIndex = 8
        Me.fraCriterio.Text = "*Criterio de Búsqueda"
        Me.fraCriterio.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraCriterio, "")
        '
        '_optCriterio_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCriterio_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCriterio_0, False)
        Me._optCriterio_0.AutoSize = True
        Me._optCriterio_0.BackColor = System.Drawing.Color.Transparent
        Me._optCriterio_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optCriterio_0, "Default")
        Me._optCriterio_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCriterio_0.ForeColor = System.Drawing.Color.Navy
        Me._optCriterio_0.Location = New System.Drawing.Point(121, 13)
        Me._optCriterio_0.Name = "_optCriterio_0"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_0, "1017")
        Me._optCriterio_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_0.Size = New System.Drawing.Size(87, 17)
        Me._optCriterio_0.TabIndex = 0
        Me._optCriterio_0.TabStop = True
        Me._optCriterio_0.Tag = "1"
        Me._optCriterio_0.Text = "*Alfabético"
        Me._optCriterio_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCriterio_0, "")
        '
        '_optCriterio_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCriterio_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCriterio_1, False)
        Me._optCriterio_1.AutoSize = True
        Me._optCriterio_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optCriterio_1, "Default")
        Me._optCriterio_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCriterio_1.ForeColor = System.Drawing.Color.Navy
        Me._optCriterio_1.Location = New System.Drawing.Point(121, 31)
        Me._optCriterio_1.Name = "_optCriterio_1"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_1, "1093")
        Me._optCriterio_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_1.Size = New System.Drawing.Size(69, 17)
        Me._optCriterio_1.TabIndex = 1
        Me._optCriterio_1.Tag = "2"
        Me._optCriterio_1.Text = "*Código"
        Me._optCriterio_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCriterio_1, "")
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
        Me.cmdSalir.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSalir.Image = CType(resources.GetObject("cmdSalir.Image"), System.Drawing.Image)
        Me.cmdSalir.Location = New System.Drawing.Point(149, 212)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSalir, System.Drawing.Color.Silver)
        Me.cmdSalir.Name = "cmdSalir"
        Me.cmdSalir.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSalir.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdSalir, 1)
        Me.cmdSalir.TabIndex = 6
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
        Me.cmdEscoger.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdEscoger.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdEscoger.Image = CType(resources.GetObject("cmdEscoger.Image"), System.Drawing.Image)
        Me.cmdEscoger.Location = New System.Drawing.Point(149, 161)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdEscoger, System.Drawing.Color.Silver)
        Me.cmdEscoger.Name = "cmdEscoger"
        Me.cmdEscoger.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdEscoger.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdEscoger, 1)
        Me.cmdEscoger.TabIndex = 5
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
        Me._cmdBuscar_1.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBuscar_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBuscar_1.Image = CType(resources.GetObject("_cmdBuscar_1.Image"), System.Drawing.Image)
        Me._cmdBuscar_1.Location = New System.Drawing.Point(149, 110)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBuscar_1, System.Drawing.Color.Silver)
        Me._cmdBuscar_1.Name = "_cmdBuscar_1"
        Me._cmdBuscar_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBuscar_1.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBuscar_1, 1)
        Me._cmdBuscar_1.TabIndex = 4
        Me._cmdBuscar_1.Text = "Si&gtes."
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
        Me._cmdBuscar_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBuscar_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBuscar_0.Image = CType(resources.GetObject("_cmdBuscar_0.Image"), System.Drawing.Image)
        Me._cmdBuscar_0.Location = New System.Drawing.Point(149, 59)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBuscar_0, System.Drawing.Color.Silver)
        Me._cmdBuscar_0.Name = "_cmdBuscar_0"
        Me._cmdBuscar_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBuscar_0.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBuscar_0, 1)
        Me._cmdBuscar_0.TabIndex = 3
        Me._cmdBuscar_0.Text = "&Buscar"
        Me._cmdBuscar_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBuscar_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBuscar_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBuscar_0, "")
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
        Me.COBISStyleProvider.SetEnableStyle(Me.grdResultados, True)
        Me.grdResultados.FixedCols = CType(1, Short)
        Me.grdResultados.FixedRows = CType(1, Short)
        Me.grdResultados.ForeColor = System.Drawing.Color.Black
        Me.grdResultados.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdResultados.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdResultados.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdResultados.HighLight = True
        Me.grdResultados.Location = New System.Drawing.Point(10, 103)
        Me.grdResultados.Name = "grdResultados"
        Me.grdResultados.Picture = Nothing
        Me.grdResultados.Row = CType(1, Short)
        Me.grdResultados.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdResultados.Size = New System.Drawing.Size(460, 198)
        Me.grdResultados.Sort = CType(2, Short)
        Me.grdResultados.TabIndex = 4
        Me.grdResultados.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdResultados, "")
        '
        'lblEtiqueta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblEtiqueta, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblEtiqueta, False)
        Me.lblEtiqueta.AutoSize = True
        Me.lblEtiqueta.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblEtiqueta, "Default")
        Me.lblEtiqueta.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEtiqueta.ForeColor = System.Drawing.Color.Navy
        Me.lblEtiqueta.Location = New System.Drawing.Point(10, 73)
        Me.lblEtiqueta.Name = "lblEtiqueta"
        Me.COBISResourceProvider.SetResourceID(Me.lblEtiqueta, "1820")
        Me.lblEtiqueta.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEtiqueta.Size = New System.Drawing.Size(123, 13)
        Me.lblEtiqueta.TabIndex = 9
        Me.lblEtiqueta.Text = "*Valor de Búsqueda:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblEtiqueta, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBEscoger, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(501, 25)
        Me.TSBotones.TabIndex = 10
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
        Me.TSBBuscar.Tag = "4"
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "30001")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "1008")
        Me.TSBSiguiente.Size = New System.Drawing.Size(81, 22)
        Me.TSBSiguiente.Tag = "5"
        Me.TSBSiguiente.Text = "*Si&guiente"
        '
        'TSBEscoger
        '
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "30002")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "1325")
        Me.TSBEscoger.Size = New System.Drawing.Size(73, 22)
        Me.TSBEscoger.Tag = "6"
        Me.TSBEscoger.Text = "*&Escoger"
        '
        'TSBSalir
        '
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Tag = "7"
        Me.TSBSalir.Text = "*&Salir"
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.fraCriterio)
        Me.PFormas.Controls.Add(Me.lblEtiqueta)
        Me.PFormas.Controls.Add(Me.txtValor)
        Me.PFormas.Controls.Add(Me.grdResultados)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(488, 310)
        Me.PFormas.TabIndex = 11
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'FBuscarGrupoClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Location = New System.Drawing.Point(56, 125)
        Me.Name = "FBuscarGrupoClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(501, 353)
        Me.Text = "Búsqueda de Grupos Económicos"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.fraCriterio, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraCriterio.ResumeLayout(False)
        Me.fraCriterio.PerformLayout()
        CType(Me.grdResultados, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptCriterio()
        Me.optCriterio(0) = _optCriterio_0
        Me.optCriterio(1) = _optCriterio_1
    End Sub
    Sub InitializecmdBuscar()
        Me.cmdBuscar(1) = _cmdBuscar_1
        Me.cmdBuscar(0) = _cmdBuscar_0
    End Sub
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


