# recursively do clang format on all cpp and hpp files in cmd bash
for /f "usebackq delims=|" %%f in (`dir /s /b ^|findstr "\.cpp \.hpp"`) do call clang-format -i -style=file %%f