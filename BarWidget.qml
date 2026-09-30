import QtQuick
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "derekross.bitcoin"

  function injectPanel() {
    var target = panelLoader.item
    if (!target) return
    if ("bar" in target) target.bar = root.bar
    if ("settings" in target) target.settings = root.settings
    if ("anchorItem" in target) target.anchorItem = button
    if ("hostWidget" in target) target.hostWidget = root
  }

  function refresh() { if (panelLoader.item) panelLoader.item.refresh(true) }
  function togglePanel() { if (panelLoader.item) panelLoader.item.toggle() }
  function open() { if (panelLoader.item) panelLoader.item.openFromHotkey() }
  function close() { if (panelLoader.item) panelLoader.item.close() }
  function closeForPopoutSwitch() { if (panelLoader.item) panelLoader.item.closeForPopoutSwitch() }
  function cycleBarMode() { if (panelLoader.item) panelLoader.item.cycleBarMode() }

  readonly property bool opened: panelLoader.item ? panelLoader.item.opened === true : false
  readonly property bool popoutSwitchClosing: panelLoader.item ? panelLoader.item.popoutSwitchClosing === true : false
  readonly property string label: panelLoader.item ? panelLoader.item.barLabel : "₿"
  readonly property bool stale: panelLoader.item ? panelLoader.item.stale : true

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  onBarChanged: injectPanel()
  onSettingsChanged: injectPanel()

  Loader {
    id: panelLoader
    active: true
    source: Qt.resolvedUrl("Panel.qml")
    visible: false
    onLoaded: {
      root.injectPanel()
      Qt.callLater(root.injectPanel)
    }
  }

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.label
    fontSize: root.label.length > 3 ? Style.font.bodySmall : Style.bar.iconFont
    horizontalMargin: 8.75
    dimmed: root.stale
    tooltipText: root.stale ? "Bitcoin data is stale — middle-click to refresh" : "Click for details · right-click to switch view"

    onPressed: function(mouseButton) {
      if (mouseButton === Qt.RightButton) root.cycleBarMode()
      else if (mouseButton === Qt.MiddleButton) root.refresh()
      else root.togglePanel()
    }
  }
}
