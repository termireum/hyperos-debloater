#!/bin/bash

# ============================================================
#   HyperOS Debloater
#   Author  : @termireum
#   Version : 2.0
#   License : MIT
#
#   A debloat & restore tool for Xiaomi/Redmi/POCO devices
#   running HyperOS or MIUI. Uses ADB via USB or Wi-Fi.
#   All packages are removed with --user 0 (non-destructive)
#   and can be restored at any time.
# ============================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

packages=(
    # === ANDROID BLOATWARE ===
    "android.autoinstalls.config.Xiaomi.model"
    "com.android.apps.tag"
    "com.android.backupconfirm"
    "com.android.bips"
    "com.android.bluetoothmidiservice"
    "com.android.bookmarkprovider"
    "com.android.calllogbackup"
    "com.android.cellbroadcastreceiver"
    "com.android.cellbroadcastreceiver.overlay.common"
    "com.android.cts.ctsshim"
    "com.android.cts.priv.ctsshim"
    "com.android.deskclock"
    "com.android.dreams.basic"
    "com.android.dreams.phototable"
    "com.android.egg"
    "com.android.emergency"
    "com.android.hotwordenrollment.okgoogle"
    "com.android.hotwordenrollment.xgoogle"
    "com.android.musicfx"
    "com.android.nfc"
    "com.android.ons"
    "com.android.printspooler"
    "com.android.providers.blockednumber"
    "com.android.providers.calendar"
    "com.android.providers.partnerbookmarks"
    "com.android.providers.userdictionary"
    "com.android.sharedstoragebackup"
    "com.android.stk"
    "com.android.theme.font.notoserifsource"
    "com.android.traceur"
    "com.android.vpndialogs"
    "com.android.wallpaper.livepicker"
    "com.android.wallpaperbackup"
    "com.android.wallpapercropper"
    "com.android.companiondevicemanager"
    "com.android.companiondevicemanager.auto_generated_characteristics_rro"
    "com.android.htmlviewer"
    "com.android.hotspot2.osulogin"
    "com.android.dynsystem"
    "com.android.DeviceAsWebcam"
    "com.android.devicediagnostics"
    "com.android.managedprovisioning"
    "com.android.managedprovisioning.overlay"
    "com.android.soundpicker"
    "com.android.avatarpicker"
    "com.android.thememanager"

    # === FACEBOOK ===
    "com.facebook.appmanager"
    "com.facebook.services"
    "com.facebook.system"

    # === FIDO / FINGERPRINT TEST ===
    "com.fido.asm"
    "com.fingerprints.sensortesttool"
    "com.goodix.gftest"

    # === GOOGLE BLOATWARE ===
    "com.google.android.apps.docs"
    "com.google.android.apps.maps"
    "com.google.android.apps.messaging"
    "com.google.android.apps.photos"
    "com.google.android.apps.restore"
    "com.google.android.apps.safetyhub"
    "com.google.android.apps.subscriptions.red"
    "com.google.android.apps.tachyon"
    "com.google.android.apps.turbo"
    "com.google.android.apps.wellbeing"
    "com.google.android.apps.youtube.music"
    "com.google.android.apps.healthdata"
    "com.google.android.as"
    "com.google.android.feedback"
    "com.google.android.federatedcompute"
    "com.google.android.gm"
    "com.google.android.gms.location.history"
    "com.google.android.gms.supervision"
    "com.google.android.googlequicksearchbox"
    "com.google.android.health.connect.backuprestore"
    "com.google.android.healthconnect.controller"
    "com.google.android.inputmethod.latin"
    "com.google.android.marvin.talkback"
    "com.google.android.onetimeinitializer"
    "com.google.android.ondevicepersonalization.services"
    "com.google.android.overlay.devicelockcontroller"
    "com.google.android.partnersetup"
    "com.google.android.printservice.recommendation"
    "com.google.android.projection.gearhead"
    "com.google.android.setupwizard"
    "com.google.android.syncadapters.calendar"
    "com.google.android.tts"
    "com.google.android.videos"
    "com.google.android.youtube"
    "com.google.android.adservices.api"
    "com.google.android.accessibility.switchaccess"
    "com.google.android.appsearch.apk"
    "com.google.android.sdksandbox"
    "com.google.android.devicelockcontroller"
    "com.google.ambient.streaming"
    "com.google.mainline.adservices"
    "com.google.mainline.telemetry"

    # === LONGCHEER / QUALCOMM ===
    "com.longcheertel.AutoTest"
    "com.longcheertel.cit"
    "com.longcheertel.sarauth"
    "com.qti.qualcomm.datastatusnotification"
    "com.qti.qualcomm.deviceinfo"
    "com.qti.snapdragon.qdcm_ff"
    "com.qti.xdivert"
    "com.qualcomm.atfwd"
    "com.qualcomm.location"
    "com.qualcomm.qti.confdialer"
    "com.qualcomm.qti.devicestatisticsservice"
    "com.qualcomm.qti.remoteSimlockAuth"
    "com.qualcomm.qti.ridemodeaudio"
    "com.qualcomm.qti.uim"
    "com.qualcomm.qti.workloadclassifier"
    "com.qualcomm.timeservice"
    "com.qualcomm.wfd.service"
    "com.quicinc.voice.activation"

    # === MI / MIUI / HYPEROS BLOATWARE ===
    "com.mi.android.globalFileexplorer"
    "com.mi.appfinder"
    "com.mi.global.shop"
    "com.mi.globalbrowser"
    "com.mi.globallayout"
    "com.mi.globalminusscreen"
    "com.milink.service"
    "com.miui.analytics"
    "com.miui.android.fashiongallery"
    "com.miui.aod"
    "com.miui.audiomonitor"
    "com.miui.backup"
    "com.miui.bugreport"
    "com.miui.cleaner"
    "com.miui.cloudbackup"
    "com.miui.cloudservice"
    "com.miui.daemon"
    "com.miui.extraphoto"
    "com.miui.face"
    "com.miui.fm"
    "com.miui.fmservice"
    "com.miui.freeform"
    "com.miui.gallery"
    "com.miui.global.packageinstaller"
    "com.miui.mediaviewer"
    "com.miui.micloudsync"
    "com.miui.miservice"
    "com.miui.misightservice"
    "com.miui.misound"
    "com.miui.miwallpaper.overlay"
    "com.miui.miwallpaper.overlay.customize"
    "com.miui.msa.global"
    "com.miui.phone.carriers.overlay.h3g"
    "com.miui.phone.carriers.overlay.vodafone"
    "com.miui.phrase"
    "com.miui.player"
    "com.miui.qr"
    "com.miui.rom"
    "com.miui.securityadd"
    "com.miui.thirdappassistant"
    "com.miui.videoplayer"
    "com.miui.virtualsim"
    "com.miui.vsimcore"
    "com.miui.yellowpage"
    "com.miuix.editor"

    # === XIAOMI ACCOUNT & SERVICES ===
    "com.xiaomi.account"
    "com.xiaomi.aicr"
    "com.xiaomi.aiasst.vision"
    "com.xiaomi.barrage"
    "com.xiaomi.calendar"
    "com.xiaomi.cameramind"
    "com.xiaomi.discover"
    "com.xiaomi.finddevice"
    "com.xiaomi.glgm"
    "com.xiaomi.micloud.sdk"
    "com.xiaomi.mipicks"
    "com.xiaomi.mircs"
    "com.xiaomi.mtb"
    "com.xiaomi.payment"
    "com.xiaomi.simactivate.service"
    "com.xiaomi.ugd"
    "com.xiaomi.xmsfkeeper"

    # === MISC ===
    "com.amazon.appmanager"
    "com.bsp.logmanager"
    "com.microsoftsdk.crossdeviceservicebroker"
    "com.novatek.novavis"
    "com.wdstechnology.android.kryten"
    "org.ifaa.aidl.manager"
)

# ─────────────────────────────────────────
#   FUNCTIONS
# ─────────────────────────────────────────

print_banner() {
    echo ""
    echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}${BOLD}║        HyperOS / MIUI Debloater          ║${RESET}"
    echo -e "${CYAN}${BOLD}║         for Xiaomi / Redmi / POCO        ║${RESET}"
    echo -e "${CYAN}${BOLD}║                                          ║${RESET}"
    echo -e "${CYAN}${BOLD}║  Author  : @termireum                    ║${RESET}"
    echo -e "${CYAN}${BOLD}║  Version : 2.0                           ║${RESET}"
    echo -e "${CYAN}${BOLD}║  License : MIT                           ║${RESET}"
    echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════╝${RESET}"
    echo ""
    echo -e "  Remove bloatware from HyperOS/MIUI devices"
    echo -e "  safely using ${BOLD}pm uninstall --user 0${RESET}."
    echo -e "  All packages can be restored at any time."
    echo ""
}

check_adb() {
    if ! command -v adb &>/dev/null; then
        echo -e "${RED}❌ ADB is not installed or not in PATH.${RESET}"
        echo -e "   Download: https://developer.android.com/tools/releases/platform-tools"
        exit 1
    fi

    if ! adb devices | grep -q "device$"; then
        echo -e "${RED}❌ No ADB device connected.${RESET}"
        echo ""
        echo -e "  ${BOLD}Via Wi-Fi (Linux/macOS/Windows):${RESET}"
        echo -e "  1. Settings → Developer Options → Wireless Debugging → ON"
        echo -e "  2. adb pair <IP>:<PAIR_PORT> <CODE>"
        echo -e "  3. adb connect <IP>:<PORT>"
        echo -e "  4. export ANDROID_SERIAL=<IP>:<PORT>"
        echo ""
        echo -e "  ${BOLD}Via USB (Windows):${RESET}"
        echo -e "  1. Settings → Developer Options → USB Debugging → ON"
        echo -e "  2. Plug in USB cable and tap Allow"
        echo ""
        exit 1
    fi
}

run_debloat() {
    echo ""
    echo -e "${YELLOW}${BOLD}  ⚠️  WARNING${RESET}"
    echo -e "${YELLOW}  ══════════════════════════════════════════${RESET}"
    echo -e "  This will uninstall ${BOLD}${#packages[@]} packages${RESET} from your device."
    echo ""
    echo -e "  • Your personal data will ${BOLD}NOT${RESET} be deleted"
    echo -e "  • This is ${BOLD}NOT${RESET} permanent — packages can be restored"
    echo -e "  • Some packages may already be absent on your ROM"
    echo -e "  • Use at your own risk"
    echo -e "${YELLOW}  ══════════════════════════════════════════${RESET}"
    echo ""
    read -p "  Do you want to continue? [y/N] " confirm
    echo ""

    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}  Debloat cancelled.${RESET}"
        echo ""
        return
    fi

    echo -e "${GREEN}  Starting debloat...${RESET}"
    echo ""

    local success=0
    local failed=0
    local not_found=0

    for package in "${packages[@]}"; do
        [[ "$package" == \#* ]] && continue
        [[ -z "$package" ]] && continue
        package="${package// /}"

        result=$(adb shell pm uninstall --user 0 "$package" 2>&1)

        if echo "$result" | grep -q "Success"; then
            echo -e "  ${GREEN}✅ $package${RESET}"
            ((success++))
        elif echo "$result" | grep -qE "not installed|Unknown package"; then
            echo -e "  ⚪ $package (not found)"
            ((not_found++))
        else
            echo -e "  ${RED}❌ $package (failed — protected by system)${RESET}"
            ((failed++))
        fi
    done

    echo ""
    echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════${RESET}"
    echo -e "  ${BOLD}Debloat complete!${RESET}"
    echo -e "  ${GREEN}✅ Removed   : $success${RESET}"
    echo -e "  ${RED}❌ Failed    : $failed${RESET}"
    echo -e "  ⚪ Not found : $not_found"
    echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════${RESET}"
    echo ""
}

run_restore() {
    echo ""
    echo -e "${CYAN}  Starting restore...${RESET}"
    echo ""

    local success=0
    local failed=0
    local not_found=0

    for package in "${packages[@]}"; do
        [[ "$package" == \#* ]] && continue
        [[ -z "$package" ]] && continue
        package="${package// /}"

        result=$(adb shell cmd package install-existing "$package" 2>&1)

        if echo "$result" | grep -q "installed for user"; then
            echo -e "  ${GREEN}✅ $package${RESET}"
            ((success++))
        elif echo "$result" | grep -qE "not found|Unknown"; then
            echo -e "  ⚪ $package (not available on this ROM)"
            ((not_found++))
        else
            echo -e "  ${RED}❌ $package (failed)${RESET}"
            ((failed++))
        fi
    done

    echo ""
    echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════${RESET}"
    echo -e "  ${BOLD}Restore complete!${RESET}"
    echo -e "  ${GREEN}✅ Restored  : $success${RESET}"
    echo -e "  ${RED}❌ Failed    : $failed${RESET}"
    echo -e "  ⚪ Not found : $not_found"
    echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════${RESET}"
    echo ""
}

show_help() {
    echo ""
    echo -e "${BOLD}  USAGE${RESET}"
    echo -e "  ──────────────────────────────────────────"
    echo -e "  ./hyperos_debloater.sh"
    echo -e "  Then choose an option from the menu."
    echo ""
    echo -e "${BOLD}  CONNECT VIA WI-FI (Linux/macOS/Windows)${RESET}"
    echo -e "  ──────────────────────────────────────────"
    echo -e "  1. Settings → Developer Options → Wireless Debugging → ON"
    echo -e "  2. Tap 'Pair device with pairing code'"
    echo -e "  3. adb pair <IP>:<PAIR_PORT> <6_DIGIT_CODE>"
    echo -e "  4. adb connect <IP>:<CONNECT_PORT>"
    echo -e "  5. export ANDROID_SERIAL=<IP>:<PORT>"
    echo -e "  6. Run this script"
    echo ""
    echo -e "${BOLD}  CONNECT VIA USB (Windows)${RESET}"
    echo -e "  ──────────────────────────────────────────"
    echo -e "  1. Install Xiaomi USB Driver"
    echo -e "  2. Settings → Developer Options → USB Debugging → ON"
    echo -e "  3. Plug in USB cable, tap Allow on device"
    echo -e "  4. Run this script"
    echo ""
    echo -e "${BOLD}  RESTORE A SINGLE PACKAGE${RESET}"
    echo -e "  ──────────────────────────────────────────"
    echo -e "  adb shell cmd package install-existing <package.name>"
    echo ""
    echo -e "${BOLD}  NOTES${RESET}"
    echo -e "  ──────────────────────────────────────────"
    echo -e "  • Packages are removed with 'pm uninstall --user 0'"
    echo -e "  • Safe — no data loss, no bootloop risk"
    echo -e "  • Wi-Fi Debugging port changes on every device reboot"
    echo -e "  • Some packages protected by HyperOS cannot be removed"
    echo ""
}

show_menu() {
    echo -e "${BOLD}  Select an option:${RESET}"
    echo ""
    echo -e "  ${CYAN}[1]${RESET} Debloat  — Remove bloatware packages"
    echo -e "  ${CYAN}[2]${RESET} Restore  — Reinstall all removed packages"
    echo -e "  ${CYAN}[3]${RESET} Help     — Usage & connection guide"
    echo -e "  ${CYAN}[0]${RESET} Exit"
    echo ""
    read -p "  Your choice: " choice
    echo ""

    case "$choice" in
        1) run_debloat ;;
        2) run_restore ;;
        3) show_help ;;
        0) echo -e "  Goodbye! 👋"; echo ""; exit 0 ;;
        *) echo -e "${RED}  Invalid option. Please try again.${RESET}"; echo ""; show_menu ;;
    esac
}

# ─────────────────────────────────────────
#   MAIN
# ─────────────────────────────────────────

print_banner
check_adb
show_menu
