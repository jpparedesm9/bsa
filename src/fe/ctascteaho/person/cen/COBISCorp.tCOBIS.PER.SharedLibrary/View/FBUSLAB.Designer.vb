<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FBuscarLaborClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializeoptCriterio()
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
	Private WithEvents _optCriterio_2 As System.Windows.Forms.RadioButton
	Public WithEvents grdResultados As COBISCorp.Framework.UI.Components.COBISGrid
	Private WithEvents _optCriterio_0 As System.Windows.Forms.RadioButton
	Private WithEvents _optCriterio_1 As System.Windows.Forms.RadioButton
	Public WithEvents txtValor As System.Windows.Forms.TextBox
	Public WithEvents fraCriterio As Infragistics.Win.Misc.UltraGroupBox
	Public WithEvents cmdSalir As System.Windows.Forms.Button
	Public WithEvents cmdEscoger As System.Windows.Forms.Button
	Private WithEvents _cmdBuscar_1 As System.Windows.Forms.Button
	Private WithEvents _cmdBuscar_0 As System.Windows.Forms.Button
	Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
	Public WithEvents lblnombre As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
	Public cmdBuscar(1) As System.Windows.Forms.Button
	Public lblEtiqueta(2) As System.Windows.Forms.Label
	Public optCriterio(2) As System.Windows.Forms.RadioButton
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FBuscarLaborClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._optCriterio_2 = New System.Windows.Forms.RadioButton()
        Me.grdResultados = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._optCriterio_0 = New System.Windows.Forms.RadioButton()
        Me._optCriterio_1 = New System.Windows.Forms.RadioButton()
        Me.txtValor = New System.Windows.Forms.TextBox()
        Me.fraCriterio = New Infragistics.Win.Misc.UltraGroupBox()
        Me.cmdSalir = New System.Windows.Forms.Button()
        Me.cmdEscoger = New System.Windows.Forms.Button()
        Me._cmdBuscar_1 = New System.Windows.Forms.Button()
        Me._cmdBuscar_0 = New System.Windows.Forms.Button()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me.lblnombre = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
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
        CType(Me.grdResultados, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.fraCriterio, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraCriterio.SuspendLayout()
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
        '_optCriterio_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCriterio_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCriterio_2, False)
        Me._optCriterio_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optCriterio_2, "Default")
        Me._optCriterio_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCriterio_2.ForeColor = System.Drawing.Color.Navy
        Me._optCriterio_2.Location = New System.Drawing.Point(63, 51)
        Me._optCriterio_2.Name = "_optCriterio_2"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_2, "1318")
        Me._optCriterio_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_2.Size = New System.Drawing.Size(334, 20)
        Me._optCriterio_2.TabIndex = 2
        Me._optCriterio_2.Tag = "3"
        Me._optCriterio_2.Text = "*Empresas en las que labora una persona determinada"
        Me._optCriterio_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCriterio_2, "")
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
        Me.grdResultados.Location = New System.Drawing.Point(10, 124)
        Me.grdResultados.Name = "grdResultados"
        Me.grdResultados.Picture = Nothing
        Me.grdResultados.Row = CType(1, Short)
        Me.grdResultados.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdResultados.Size = New System.Drawing.Size(454, 171)
        Me.grdResultados.Sort = CType(2, Short)
        Me.grdResultados.TabIndex = 5
        Me.grdResultados.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdResultados, "")
        '
        '_optCriterio_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCriterio_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCriterio_0, False)
        Me._optCriterio_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optCriterio_0, "Default")
        Me._optCriterio_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCriterio_0.ForeColor = System.Drawing.Color.Navy
        Me._optCriterio_0.Location = New System.Drawing.Point(63, 15)
        Me._optCriterio_0.Name = "_optCriterio_0"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_0, "1320")
        Me._optCriterio_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_0.Size = New System.Drawing.Size(334, 20)
        Me._optCriterio_0.TabIndex = 0
        Me._optCriterio_0.Tag = "1"
        Me._optCriterio_0.Text = "*Empresas que forman parte de un grupo"
        Me._optCriterio_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCriterio_0, "")
        '
        '_optCriterio_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCriterio_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCriterio_1, False)
        Me._optCriterio_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optCriterio_1, "Default")
        Me._optCriterio_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCriterio_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCriterio_1.ForeColor = System.Drawing.Color.Navy
        Me._optCriterio_1.Location = New System.Drawing.Point(63, 32)
        Me._optCriterio_1.Name = "_optCriterio_1"
        Me.COBISResourceProvider.SetResourceID(Me._optCriterio_1, "1635")
        Me._optCriterio_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCriterio_1.Size = New System.Drawing.Size(334, 20)
        Me._optCriterio_1.TabIndex = 1
        Me._optCriterio_1.Tag = "2"
        Me._optCriterio_1.Text = "*Personas que trabajan en una empresa determinada"
        Me._optCriterio_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCriterio_1, "")
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
        Me.txtValor.Location = New System.Drawing.Point(75, 96)
        Me.txtValor.MaxLength = 10
        Me.txtValor.Name = "txtValor"
        Me.txtValor.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtValor.Size = New System.Drawing.Size(67, 20)
        Me.txtValor.TabIndex = 3
        Me.txtValor.Tag = "4"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtValor, "")
        '
        'fraCriterio
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraCriterio, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraCriterio, False)
        Me.fraCriterio.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraCriterio.Controls.Add(Me._optCriterio_2)
        Me.fraCriterio.Controls.Add(Me._optCriterio_0)
        Me.fraCriterio.Controls.Add(Me._optCriterio_1)
        Me.COBISStyleProvider.SetControlStyle(Me.fraCriterio, "Default")
        Me.fraCriterio.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fraCriterio.ForeColor = System.Drawing.Color.Navy
        Me.fraCriterio.Location = New System.Drawing.Point(10, 10)
        Me.fraCriterio.Name = "fraCriterio"
        Me.COBISResourceProvider.SetResourceID(Me.fraCriterio, "1128")
        Me.fraCriterio.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraCriterio.Size = New System.Drawing.Size(454, 77)
        Me.fraCriterio.TabIndex = 9
        Me.fraCriterio.Text = "*Criterio de B�squeda"
        Me.fraCriterio.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraCriterio, "")
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
        Me.cmdSalir.Location = New System.Drawing.Point(138, 197)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSalir, System.Drawing.Color.Silver)
        Me.cmdSalir.Name = "cmdSalir"
        Me.cmdSalir.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSalir.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdSalir, 1)
        Me.cmdSalir.TabIndex = 8
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
        Me.cmdEscoger.Enabled = False
        Me.cmdEscoger.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdEscoger.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdEscoger.Image = CType(resources.GetObject("cmdEscoger.Image"), System.Drawing.Image)
        Me.cmdEscoger.Location = New System.Drawing.Point(138, 146)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdEscoger, System.Drawing.Color.Silver)
        Me.cmdEscoger.Name = "cmdEscoger"
        Me.cmdEscoger.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdEscoger.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdEscoger, 1)
        Me.cmdEscoger.TabIndex = 7
        Me.cmdEscoger.Text = "&Escoger"
        Me.cmdEscoger.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdEscoger.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdEscoger.UseVisualStyleBackColor = True
        Me.cmdEscoger.Visible = False
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
        Me._cmdBuscar_1.Location = New System.Drawing.Point(138, 95)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBuscar_1, System.Drawing.Color.Silver)
        Me._cmdBuscar_1.Name = "_cmdBuscar_1"
        Me._cmdBuscar_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBuscar_1.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBuscar_1, 1)
        Me._cmdBuscar_1.TabIndex = 6
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
        Me._cmdBuscar_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBuscar_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBuscar_0.Image = CType(resources.GetObject("_cmdBuscar_0.Image"), System.Drawing.Image)
        Me._cmdBuscar_0.Location = New System.Drawing.Point(138, 44)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBuscar_0, System.Drawing.Color.Silver)
        Me._cmdBuscar_0.Name = "_cmdBuscar_0"
        Me._cmdBuscar_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBuscar_0.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBuscar_0, 1)
        Me._cmdBuscar_0.TabIndex = 4
        Me._cmdBuscar_0.Text = "&Buscar"
        Me._cmdBuscar_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBuscar_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBuscar_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBuscar_0, "")
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
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 96)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "1628")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(62, 13)
        Me._lblEtiqueta_2.TabIndex = 12
        Me._lblEtiqueta_2.Text = "*Persona:"
        Me._lblEtiqueta_2.TextAlign = System.Drawing.ContentAlignment.TopRight
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
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 94)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "1317")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(64, 13)
        Me._lblEtiqueta_1.TabIndex = 13
        Me._lblEtiqueta_1.Text = "*Empresa:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        'lblnombre
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblnombre, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblnombre, False)
        Me.lblnombre.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblnombre.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblnombre, "Default")
        Me.lblnombre.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblnombre.Location = New System.Drawing.Point(144, 96)
        Me.lblnombre.Name = "lblnombre"
        Me.lblnombre.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblnombre.Size = New System.Drawing.Size(320, 20)
        Me.lblnombre.TabIndex = 11
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblnombre, "")
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
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 94)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "1390")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(50, 13)
        Me._lblEtiqueta_0.TabIndex = 10
        Me._lblEtiqueta_0.Text = "*Grupo:"
        Me._lblEtiqueta_0.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBEscoger, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(490, 25)
        Me.TSBotones.TabIndex = 14
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
        Me.TSBBuscar.Tag = "5"
        Me.TSBBuscar.Text = "*Buscar"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "30001")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "1008")
        Me.TSBSiguiente.Size = New System.Drawing.Size(81, 22)
        Me.TSBSiguiente.Tag = "6"
        Me.TSBSiguiente.Text = "*Siguiente"
        '
        'TSBEscoger
        '
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "30002")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "1325")
        Me.TSBEscoger.Size = New System.Drawing.Size(73, 22)
        Me.TSBEscoger.Tag = "7"
        Me.TSBEscoger.Text = "*Escoger"
        '
        'TSBSalir
        '
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Tag = "8"
        Me.TSBSalir.Text = "*Salir"
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.fraCriterio)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me.lblnombre)
        Me.PFormas.Controls.Add(Me.grdResultados)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me.txtValor)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(473, 302)
        Me.PFormas.TabIndex = 15
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'FBuscarLaborClass
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
        Me.Location = New System.Drawing.Point(38, 148)
        Me.Name = "FBuscarLaborClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(490, 346)
        Me.Text = "B�squedas para Personalizacion de Costos de Servicios"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdResultados, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.fraCriterio, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraCriterio.ResumeLayout(False)
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
        Me.optCriterio(2) = _optCriterio_2
        Me.optCriterio(0) = _optCriterio_0
        Me.optCriterio(1) = _optCriterio_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(0) = _lblEtiqueta_0
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


