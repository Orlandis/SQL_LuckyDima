-- Good basic information about OS memory amounts and state  
SELECT total_physical_memory_kb, available_physical_memory_kb, 
       total_page_file_kb, available_page_file_kb, 
       system_memory_state_desc
FROM sys.dm_os_sys_memory WITH (NOLOCK) OPTION (RECOMPILE);

-- You want to see "Available physical memory is high"
-- This indicates that you are not under external memory pressure
-- ���� �� ������ "Available physical memory is high"
-- ��� �������, ��� ������ �� ���������� ��� ���������


-- SQL Server Process Address space info  
--(shows whether locked pages is enabled, among other things)
SELECT physical_memory_in_use_kb,locked_page_allocations_kb, 
       page_fault_count, memory_utilization_percentage, 
       available_commit_limit_kb, process_physical_memory_low, 
       process_virtual_memory_low
FROM sys.dm_os_process_memory WITH (NOLOCK) OPTION (RECOMPILE);

-- You want to see 0 for process_physical_memory_low
-- You want to see 0 for process_virtual_memory_low
-- This indicates that you are not under internal memory pressure
-- ���� �� ������ 0 ��� process_physical_memory_low
-- ���� �� ������ 0 ��� process_virtual_memory_low
-- ��� �������, ��� ������ �� ���������� ��� ���������


-- Page Life Expectancy (PLE) value for each NUMA node in current instance  
SELECT @@SERVERNAME AS [Server Name], [object_name], instance_name, cntr_value AS [Page Life Expectancy]
FROM sys.dm_os_performance_counters WITH (NOLOCK)
WHERE [object_name] LIKE N'%Buffer Node%' -- Handles named instances
AND counter_name = N'Page life expectancy' OPTION (RECOMPILE);

-- PLE is a good measurement of memory pressure.
-- Higher PLE is better. Watch the trend, not the absolute value.
-- This will only return one row for non-NUMA systems.
-- PLE �������� ������� �����������, �������� �� ������ ��� ���������
-- ������� PLE ��� ������. ��� ������, ��� �����.
-- ������ ������ ���� ������ ��� non-NUMA ������