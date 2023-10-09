Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class FImagenesClass
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        InitializecmdBoton()
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
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Public WithEvents grdImagen As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Public WithEvents Label1 As System.Windows.Forms.Label
    Public WithEvents Lbltitularidad As System.Windows.Forms.Label
    Public WithEvents lblnomente As System.Windows.Forms.Label
    Public WithEvents lblCodente As System.Windows.Forms.Label
    Public WithEvents lbltotalfirmas As System.Windows.Forms.Label
    Public WithEvents Label3 As System.Windows.Forms.Label
    Public WithEvents Label6 As System.Windows.Forms.Label
    Public Line1(0) As System.Windows.Forms.Label
    Public cmdBoton(1) As System.Windows.Forms.Button
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FImagenesClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me.grdImagen = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Lbltitularidad = New System.Windows.Forms.Label()
        Me.lblnomente = New System.Windows.Forms.Label()
        Me.lblCodente = New System.Windows.Forms.Label()
        Me.lbltotalfirmas = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBRefrescar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdImagen, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
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
        Me._cmdBoton_1.Enabled = False
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Location = New System.Drawing.Point(-497, 303)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 2
        Me._cmdBoton_1.Text = "&Refrescar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me._cmdBoton_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        'grdImagen
        '
        Me.grdImagen._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdImagen, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdImagen, False)
        Me.grdImagen.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdImagen.Clip = ""
        Me.grdImagen.Col = CType(1, Short)
        Me.grdImagen.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdImagen.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdImagen.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdImagen, "Default")
        Me.grdImagen.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdImagen, True)
        Me.grdImagen.FixedCols = CType(1, Short)
        Me.grdImagen.FixedRows = CType(1, Short)
        Me.grdImagen.ForeColor = System.Drawing.Color.Black
        Me.grdImagen.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdImagen.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdImagen.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdImagen.HighLight = True
        Me.grdImagen.Location = New System.Drawing.Point(10, 10)
        Me.grdImagen.Name = "grdImagen"
        Me.grdImagen.Picture = Nothing
        Me.grdImagen.Row = CType(1, Short)
        Me.grdImagen.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdImagen.Size = New System.Drawing.Size(618, 248)
        Me.grdImagen.Sort = CType(2, Short)
        Me.grdImagen.TabIndex = 0
        Me.grdImagen.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdImagen, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-560, 303)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 1
        Me._cmdBoton_0.Text = "*&Salir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        'Label1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label1, False)
        Me.Label1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Label1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.Label1, "Default")
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Location = New System.Drawing.Point(160, 314)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(201, 20)
        Me.Label1.TabIndex = 9
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label1, "")
        '
        'Lbltitularidad
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Lbltitularidad, False)
        Me.COBISViewResizer.SetAutoResize(Me.Lbltitularidad, False)
        Me.Lbltitularidad.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Lbltitularidad, "Default")
        Me.Lbltitularidad.Cursor = System.Windows.Forms.Cursors.Default
        Me.Lbltitularidad.ForeColor = System.Drawing.Color.Navy
        Me.Lbltitularidad.Location = New System.Drawing.Point(10, 314)
        Me.Lbltitularidad.Name = "Lbltitularidad"
        Me.COBISResourceProvider.SetResourceID(Me.Lbltitularidad, "5151")
        Me.Lbltitularidad.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Lbltitularidad.Size = New System.Drawing.Size(147, 20)
        Me.Lbltitularidad.TabIndex = 8
        Me.Lbltitularidad.Text = "*Titularidad:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Lbltitularidad, "")
        '
        'lblnomente
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblnomente, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblnomente, False)
        Me.lblnomente.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblnomente.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblnomente, "Default")
        Me.lblnomente.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblnomente.Location = New System.Drawing.Point(228, 291)
        Me.lblnomente.Name = "lblnomente"
        Me.lblnomente.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblnomente.Size = New System.Drawing.Size(281, 20)
        Me.lblnomente.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblnomente, "")
        '
        'lblCodente
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCodente, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCodente, False)
        Me.lblCodente.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblCodente.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblCodente, "Default")
        Me.lblCodente.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCodente.Location = New System.Drawing.Point(160, 291)
        Me.lblCodente.Name = "lblCodente"
        Me.lblCodente.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCodente.Size = New System.Drawing.Size(65, 20)
        Me.lblCodente.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCodente, "")
        '
        'lbltotalfirmas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lbltotalfirmas, False)
        Me.COBISViewResizer.SetAutoResize(Me.lbltotalfirmas, False)
        Me.lbltotalfirmas.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lbltotalfirmas.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lbltotalfirmas, "Default")
        Me.lbltotalfirmas.Cursor = System.Windows.Forms.Cursors.Default
        Me.lbltotalfirmas.Location = New System.Drawing.Point(160, 268)
        Me.lbltotalfirmas.Name = "lbltotalfirmas"
        Me.lbltotalfirmas.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lbltotalfirmas.Size = New System.Drawing.Size(273, 20)
        Me.lbltotalfirmas.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lbltotalfirmas, "")
        '
        'Label3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label3, False)
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label3, "Default")
        Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label3.ForeColor = System.Drawing.Color.Navy
        Me.Label3.Location = New System.Drawing.Point(10, 291)
        Me.Label3.Name = "Label3"
        Me.COBISResourceProvider.SetResourceID(Me.Label3, "500220")
        Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label3.Size = New System.Drawing.Size(147, 20)
        Me.Label3.TabIndex = 4
        Me.Label3.Text = "*Cliente :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label3, "")
        '
        'Label6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label6, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label6, False)
        Me.Label6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label6, "Default")
        Me.Label6.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label6.ForeColor = System.Drawing.Color.Navy
        Me.Label6.Location = New System.Drawing.Point(10, 268)
        Me.Label6.Name = "Label6"
        Me.COBISResourceProvider.SetResourceID(Me.Label6, "500221")
        Me.Label6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label6.Size = New System.Drawing.Size(147, 20)
        Me.Label6.TabIndex = 3
        Me.Label6.Text = "*Total Firmas a  Revisar:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label6, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.grdImagen)
        Me.PFormas.Controls.Add(Me.lblnomente)
        Me.PFormas.Controls.Add(Me.Label6)
        Me.PFormas.Controls.Add(Me.Label1)
        Me.PFormas.Controls.Add(Me.Label3)
        Me.PFormas.Controls.Add(Me.Lbltitularidad)
        Me.PFormas.Controls.Add(Me.lbltotalfirmas)
        Me.PFormas.Controls.Add(Me.lblCodente)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(638, 350)
        Me.PFormas.TabIndex = 11
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBRefrescar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(660, 25)
        Me.TSBotones.TabIndex = 12
        Me.TSBotones.Text = "TSBotones"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBRefrescar
        '
        Me.TSBRefrescar.ForeColor = System.Drawing.Color.Navy
        Me.TSBRefrescar.Image = CType(resources.GetObject("TSBRefrescar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBRefrescar, "2005")
        Me.TSBRefrescar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBRefrescar.Name = "TSBRefrescar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBRefrescar, "500219")
        Me.TSBRefrescar.Size = New System.Drawing.Size(80, 22)
        Me.TSBRefrescar.Text = "*&Refrescar"
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
        Me.TSBSalir.Text = "*Salir"
        '
        'FImagenesClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(80, 100)
        Me.Name = "FImagenesClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(660, 398)
        Me.Text = "Firmas y Sellos de la Cuenta"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdImagen, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(0) = _cmdBoton_0
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBRefrescar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region
End Class


