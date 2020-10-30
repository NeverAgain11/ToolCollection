import UIKit

/// An adapter for `UICollectionView` with `UICollectionViewFlowLayout` inherited from `UICollectionViewAdapter`.
open class UICollectionViewFlowLayoutAdapter: UICollectionViewAdapter {}

extension UICollectionViewFlowLayoutAdapter: UICollectionViewDelegateFlowLayout {
    /// Returns the size for item at specified index path.
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let node = cellNode(at: indexPath)
        return node.component.referenceSize(in: collectionView.bounds) ?? collectionViewLayout.flowLayout?.itemSize ?? .zero
    }

    /// Returns the size for header in specified section.
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let node = headerNode(in: section) else {
            return .zero
        }

        return node.component.referenceSize(in: collectionView.bounds) ?? collectionViewLayout.flowLayout?.headerReferenceSize ?? .zero
    }

    /// Returns the size for footer in specified section.
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let node = footerNode(in: section) else {
            return .zero
        }

        return node.component.referenceSize(in: collectionView.bounds) ?? collectionViewLayout.flowLayout?.footerReferenceSize ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return data[section].minimumLineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return data[section].minimumInteritemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return data[section].sectionInset
    }
}

private extension UICollectionViewLayout {
    var flowLayout: UICollectionViewFlowLayout? {
        return self as? UICollectionViewFlowLayout
    }
}
