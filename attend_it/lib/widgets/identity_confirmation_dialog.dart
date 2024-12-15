import 'package:flutter/material.dart';

class IdentityConfirmationDialog extends StatelessWidget {
  final Function() onConfirm;
  final Function() onRetake;
  final String? predictedName;
  final double? confidence;

  const IdentityConfirmationDialog({
    Key? key,
    required this.onConfirm,
    required this.onRetake,
    this.predictedName,
    this.confidence,
  }) : super(key: key);

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
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0047AB),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Konfirmasi'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
