/*
 * Copyright 2019 Kai Uwe Broulik <kde@privat.broulik.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.3 as QtControls
import org.kde.kirigami 2.4 as Kirigami
import org.kde.kcm 1.1 as KCM
import org.kde.private.kcms.style 1.0 as Private

KCM.GridViewKCM {
    id: root

    KCM.ConfigModule.quickHelp: i18n("This module allows you to modify the visual appearance of applications' user interface elements.")

    view.model: kcm.model
    view.currentIndex: kcm.model.selectedStyleIndex

    Component.onCompleted: {
        // The widget thumbnails are a bit more elaborate and need more room, especially when translated
        view.implicitCellWidth = Kirigami.Units.gridUnit * 20;
        view.implicitCellHeight = Kirigami.Units.gridUnit * 14;
    }

    // putting the InlineMessage as header item causes it to show up initially despite visible false
    header: ColumnLayout {
        Kirigami.InlineMessage {
            id: infoLabel
            Layout.fillWidth: true

            showCloseButton: true
            visible: false

            Connections {
                target: kcm
                onShowErrorMessage: {
                    infoLabel.type = Kirigami.MessageType.Error;
                    infoLabel.text = message;
                    infoLabel.visible = true;
                }
            }
        }
    }

    view.delegate: KCM.GridDelegate {
        id: delegate

        text: model.display
        toolTip: model.description

        thumbnailAvailable: thumbnailItem.valid
        thumbnail: Private.PreviewItem {
            id: thumbnailItem
            anchors.fill: parent
            styleName: model.styleName

            Connections {
                target: kcm
                onStyleReconfigured: {
                    if (styleName === model.styleName) {
                        thumbnailItem.reload();
                    }
                }
            }
        }

        actions: [
            Kirigami.Action {
                iconName: "document-edit"
                tooltip: i18n("Configure Style...")
                enabled: model.configurable
                onTriggered: kcm.configure(model.styleName, delegate)
            }
        ]
        onClicked: {
            kcm.model.selectedStyle = model.styleName;
            view.forceActiveFocus();
        }
    }

    footer: RowLayout {
        Layout.fillWidth: true

        QtControls.Button {
            id: effectSettingsButton
            text: i18n("Configure Icons and Toolbars")
            icon.name: "configure-toolbars" // proper icon?
            checkable: true
            checked: effectSettingsPopupLoader.item && effectSettingsPopupLoader.item.opened
            onClicked: {
                effectSettingsPopupLoader.active = true;
                effectSettingsPopupLoader.item.open();
            }
        }
    }

    Loader {
        id: effectSettingsPopupLoader
        active: false
        sourceComponent: EffectSettingsPopup {
            parent: effectSettingsButton
            y: -height
        }
    }
}