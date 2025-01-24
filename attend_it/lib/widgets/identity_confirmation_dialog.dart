import 'package:attend_it/models/schedule.dart';
import 'package:attend_it/provider/presensi_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IdentityConfirmationDialog extends StatelessWidget {
  final Function() onConfirm;
  final Function() onRetake;
  final String? predictedName;
  final double? confidence;
  final DateTime captureTime;
  final int idJadwal;
  final String waktuMulai;
  final String imagePath;
  final Schedule selectedSchedule;

  const IdentityConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.onRetake,
    required this.captureTime,
    required this.idJadwal,
    required this.waktuMulai,
    required this.imagePath,
    required this.selectedSchedule,
    this.predictedName,
    this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Konfirmasi Identitas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Terdeteksi sebagai:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              predictedName ?? 'Tidak terdeteksi',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (confidence != null) ...[
              const SizedBox(height: 10),
              Text(
                'Tingkat kepercayaan: ${(confidence! * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
            const SizedBox(height: 20),
            const Text(
              'Apakah identitas ini sudah benar?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: onRetake,
                  child: const Text('Ambil Ulang'),
                ),
                Consumer(builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      try {
                        await ref
                            .read(presensiProvider.notifier)
                            .submitPresensi(
                              idJadwal: idJadwal,
                              waktuMulai: waktuMulai,
                              captureTime: captureTime,
                            );

                        if (context.mounted) {
                          Navigator.of(context).pop();
                          context.go('/home/presensi/approving', extra: {
                            'imagePath': imagePath,
                            'selectedSchedule': selectedSchedule,
                            'captureTime': captureTime,
                          });
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Gagal menyimpan presensi: $e')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0047AB),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Konfirmasi'),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
