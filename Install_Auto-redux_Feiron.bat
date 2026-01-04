@echo off
chcp 65001 >nul
title Auto-redux Feiron v1 - Установщик
color 0A

echo ================================================
echo    Auto-redux Feiron v1 - Установщик
echo    Автор: thefeiron
echo ================================================
echo.

:: Переход в директорию скрипта
cd /d "%~dp0"

:: Проверка наличия EXE файла
if not exist "dist\Auto-redux_Feiron_v1.exe" (
    echo [ОШИБКА] Файл dist\Auto-redux_Feiron_v1.exe не найден!
    echo Убедитесь, что файл находится в правильной папке.
    pause
    exit /b 1
)

echo [ШАГ 1/3] Проверка системных требований...
echo.

:: Проверка Windows версии (не критично, но проверим)
ver | find "Windows" >nul
if errorlevel 1 (
    echo [ПРЕДУПРЕЖДЕНИЕ] Неизвестная версия Windows
) else (
    echo [OK] Операционная система: Windows
)

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ПРЕДУПРЕЖДЕНИЕ] Программа требует прав администратора для работы
    echo Программа будет запущена с правами администратора при первом запуске
) else (
    echo [OK] Права администратора доступны
)

echo.
echo [ШАГ 2/3] Создание ярлыка на рабочем столе...
powershell -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\Auto-redux Feiron v1.lnk');$s.TargetPath='%CD%\dist\Auto-redux_Feiron_v1.exe';$s.WorkingDirectory='%CD%\dist';$s.Description='Auto-redux Feiron v1 by thefeiron';$s.Save()" 2>nul
if errorlevel 1 (
    echo [ПРЕДУПРЕЖДЕНИЕ] Не удалось создать ярлык на рабочем столе
) else (
    echo [OK] Ярлык создан на рабочем столе
)

echo.
echo [ШАГ 3/3] Добавление в автозагрузку (опционально)...
echo.
set /p add_autostart="Добавить программу в автозагрузку Windows? (Y/N): "
if /i "%add_autostart%"=="Y" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "AutoReduxFeiron" /t REG_SZ /d "\"%CD%\dist\Auto-redux_Feiron_v1.exe\"" /f >nul 2>&1
    if errorlevel 1 (
        echo [ПРЕДУПРЕЖДЕНИЕ] Не удалось добавить в автозагрузку
    ) else (
        echo [OK] Программа добавлена в автозагрузку
    )
) else (
    echo [ПРОПУЩЕНО] Автозагрузка не добавлена
)

echo.
echo ================================================
echo    Установка завершена!
echo ================================================
echo.
echo Программа находится: %CD%\dist\Auto-redux_Feiron_v1.exe
echo.
echo РЕКОМЕНДАЦИИ:
echo 1. При первом запуске программа запросит права администратора
echo 2. Настройте пути к игре и модам в интерфейсе
echo 3. Создайте бэкап оригинальных файлов перед установкой модов
echo.
set /p launch="Запустить программу сейчас? (Y/N): "
if /i "%launch%"=="Y" (
    start "" "dist\Auto-redux_Feiron_v1.exe"
)

echo.
pause

