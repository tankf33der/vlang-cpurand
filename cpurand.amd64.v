module cpurand

pub fn cpu_support() bool {
	mut result := false
	asm amd64 {
		// op dst, src
		mov eax, 1
		cpuid
		bt ecx, 30
		setc result
		; =r (result)
		; ; cc
		  eax
		  ebx
		  ecx
		  edx
	}
	return result
}
