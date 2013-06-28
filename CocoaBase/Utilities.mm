#import <mach/mach.h>
#import <mach/mach_host.h>

static NSString * ttgetFreeMemory()
{
	return @"used: 1111 free: 2222 total: 3333";
}

/*
static NSString * ttgetFreeMemory()
{
	mach_port_t host_port;
	mach_msg_type_number_t host_size;
	vm_size_t pagesize;
	
	host_port = mach_host_self();
	host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
	host_page_size(host_port, &pagesize);
	
	vm_statistics_data_t vm_stat;
	
	if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
		NSLog(@"Failed to fetch vm statistics");
	
	natural_t mem_used = (vm_stat.active_count +
												vm_stat.inactive_count +
												vm_stat.wire_count) * pagesize;
	natural_t mem_free = vm_stat.free_count * pagesize;
	natural_t mem_total = mem_used + mem_free;
	NSLog(@"used: %u free: %u total: %u", mem_used, mem_free, mem_total);
	
	return [NSString stringWithFormat:@"used: %u free: %u total: %u", mem_used, mem_free, mem_total];
}
*/


/*
#import <sys/sysctl.h>
#import <mach/host_info.h>
#import <mach/mach_host.h>
#import <mach/task_info.h>
#import <mach/task.h>


int mib[6];
mib[0] = CTL_HW;
mib[1] = HW_PAGESIZE;

int pagesize;
size_t length;
auto length = sizeof (pagesize);
if (sysctl (mib, 2, &pagesize, &length, NULL, 0) < 0)
{
	fprintf (stderr, "getting page size");
}

mach_msg_type_number_t count = HOST_VM_INFO_COUNT;

vm_statistics_data_t vmstat;
if (host_statistics (mach_host_self (), HOST_VM_INFO, (host_info_t) &vmstat, &count) != KERN_SUCCESS)
{
	fprintf (stderr, "Failed to get VM statistics.");
}

double total = vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count;
double wired = vmstat.wire_count / total;
double active = vmstat.active_count / total;
double inactive = vmstat.inactive_count / total;
double free = vmstat.free_count / total;

task_basic_info_64_data_t info;
unsigned size = sizeof (info);
task_info (mach_task_self (), TASK_BASIC_INFO_64, (task_info_t) &info, &size);

double unit = 1024 * 1024;
memLabel.text = [NSString stringWithFormat: @"% 3.1f MB\n% 3.1f MB\n% 3.1f MB", vmstat.free_count * pagesize / unit, (vmstat.free_count + vmstat.inactive_count) * pagesize / unit, info.resident_size / unit];
*/




